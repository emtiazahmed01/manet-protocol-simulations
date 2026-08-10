#!/usr/bin/env python3
"""
analyzer.py — NS-2 Trace Analyzer (AODV / DSDV / DSR / AOMDV)
=============================================================
Computes ONLY four metrics:
    * Packet Delivery Ratio (%)
    * Average End-to-End Delay (ms)
    * Average Throughput (Kbps)
    * Jitter (ms)

Handles BOTH ns-2 wireless trace formats automatically:
    * NEW format  ($ns use-newtrace)   ->  "s -t 1.0 -Hs 13 ... -Nl AGT ..."
    * OLD format  (default)            ->  "s 1.0 _13_ AGT --- 0 tcp 40 ..."

Usage
-----
    python3 analyzer.py --files AODV_34.tr
    python3 analyzer.py --files AODV_34.tr AODV_68.tr DSDV_34.tr
    python3 analyzer.py --dir ./traces

Output
------
    results.csv
    graphs/*.png   (bar charts)
"""

import re
import os
import sys
import glob
import argparse

try:
    import matplotlib
    matplotlib.use("Agg")
    import matplotlib.pyplot as plt
    HAVE_MPL = True
except ImportError:
    HAVE_MPL = False


# =================================================================
# 1. TRACE FORMAT DETECTION
# =================================================================
EVENTS = ("s", "r", "d", "f", "D")
NEW_FLAG_RE = re.compile(r"-(\w+)\s+(\S+)")


def detect_format(path, probe_lines=300):
    """Return 'new' or 'old' by probing the first few event lines."""
    with open(path, "r", errors="ignore") as f:
        for i, line in enumerate(f):
            if i > probe_lines:
                break
            if line[:1] in EVENTS and " -Ni " in line:
                return "new"
            if line[:1] in EVENTS and re.match(r"^\S+\s+[\d.]+\s+_\d+_\s", line):
                return "old"
    return "new"


# =================================================================
# 2. LINE PARSERS  ->  (event, time, level, pkt_type, size, uid)
# =================================================================
def parse_new(line):
    """NEW format: s -t 1.0 ... -Nl AGT ... -It tcp -Il 40 -Ii 0 ..."""
    if line[:1] not in EVENTS:
        return None
    f = dict(NEW_FLAG_RE.findall(line))
    try:
        t = float(f["t"])
    except (KeyError, ValueError):
        return None
    return (
        line[0],                 # event
        t,                       # time
        f.get("Nl", ""),         # trace level: AGT / RTR / MAC / IFQ
        f.get("It", ""),         # packet type: tcp / ack / cbr / AODV ...
        _f(f.get("Il")),         # packet size (bytes)
        f.get("Ii"),             # unique packet id
    )


def parse_old(line):
    """OLD format: s 1.0 _13_ AGT --- 0 tcp 40 [..] ..."""
    if line[:1] not in EVENTS:
        return None
    tok = line.split()
    if len(tok) < 8:
        return None
    try:
        t = float(tok[1])
    except ValueError:
        return None
    #  tok[0]=event tok[1]=time tok[2]=_node_ tok[3]=level
    #  tok[4]=reason tok[5]=uid  tok[6]=type  tok[7]=size
    return (tok[0], t, tok[3], tok[6], _f(tok[7]), tok[5])


def _f(x):
    try:
        return float(x)
    except (TypeError, ValueError):
        return 0.0


# =================================================================
# 3. METRIC COMPUTATION
# =================================================================
def analyze(path, pkt_filter=None):
    """
    pkt_filter : optional set of packet types to count as application data
                 (e.g. {"tcp"} or {"cbr"}). None = every AGT-level packet.
    """
    parser = parse_new if detect_format(path) == "new" else parse_old

    sent = {}       # uid -> send time
    recv = {}       # uid -> (recv time, bytes)
    first_evt = last_evt = None

    with open(path, "r", errors="ignore") as fh:
        for line in fh:
            rec = parser(line)
            if rec is None:
                continue
            event, t, level, ptype, size, uid = rec

            # Overall trace time span (packet events only, not "M" lines)
            if first_evt is None or t < first_evt:
                first_evt = t
            if last_evt is None or t > last_evt:
                last_evt = t

            # Only application-layer (AGT) traffic counts as data
            if level != "AGT" or uid is None:
                continue
            if pkt_filter and ptype.lower() not in pkt_filter:
                continue

            if event in ("+", "s") and uid not in sent:
                sent[uid] = t
            elif event == "r" and uid not in recv:
                recv[uid] = (t, size)

    sent_n = len(sent)
    recv_n = len(recv)

    # ---- PDR -----------------------------------------------------
    pdr = (recv_n / sent_n * 100.0) if sent_n else 0.0

    # ---- Delay & Jitter (matched send/receive pairs) -------------
    pairs = []                                   # (recv_time, delay_seconds)
    for uid, t_recv_size in recv.items():
        if uid in sent:
            t_recv, _ = t_recv_size
            pairs.append((t_recv, t_recv - sent[uid]))
    pairs.sort(key=lambda p: p[0])                # order by arrival time
    delays = [d for _, d in pairs]

    avg_delay_ms = (sum(delays) / len(delays) * 1000.0) if delays else 0.0

    jitter_ms = 0.0
    if len(delays) > 1:
        jitter_ms = (
            sum(abs(delays[i] - delays[i - 1]) for i in range(1, len(delays)))
            / (len(delays) - 1) * 1000.0
        )

    # ---- Throughput (same calculation as Avg_Tput.awk) -----------

    # Total received application bytes
    rx_bytes = sum(size for _, size in recv.values())

    # startTime = first AGT send
    start_time = min(sent.values()) if sent else 0.0

    # stopTime = last AGT receive
    stop_time = max(t for t, _ in recv.values()) if recv else 0.0

    window = stop_time - start_time

    if window > 0:
        throughput_kbps = (rx_bytes / window) * (8.0 / 1000.0)
    else:
        throughput_kbps = 0.0

    # Overall simulation duration
    sim_time = (
        last_evt - first_evt
        if (first_evt is not None and last_evt is not None)
        else 0.0
    )

    return {
        "sim_time": sim_time,
        "sent": sent_n,
        "received": recv_n,
        "pdr": pdr,
        "avg_delay_ms": avg_delay_ms,
        "throughput_kbps": throughput_kbps,
        "jitter_ms": jitter_ms,
        "rx_window": window,
        "format": detect_format(path),
    }


# =================================================================
# 4. FILENAME  ->  (PROTOCOL, NODES)
# =================================================================
NAME_RE = re.compile(r"([A-Za-z]+)[_\- ]*(\d+)")


def detect_protocol_and_nodes(path):
    base = os.path.splitext(os.path.basename(path))[0]
    m = NAME_RE.search(base)
    if m:
        return m.group(1).upper(), int(m.group(2))
    return base.upper(), None


def make_label(proto, nodes):
    return f"{proto}-{nodes}" if nodes is not None else proto


# =================================================================
# 5. CONSOLE OUTPUT
# =================================================================
def print_single(m):
    print("\n==============================")
    print("     NS2 PERFORMANCE ANALYSIS")
    print("==============================")
    print(f"Simulation Time      : {m['sim_time']:.2f} sec")
    print(f"Packets Sent         : {m['sent']}")
    print(f"Packets Received     : {m['received']}")
    print(f"Packet Delivery Ratio: {m['pdr']:.2f} %")
    print(f"Average Delay        : {m['avg_delay_ms']:.4f} ms")
    print(f"Throughput           : {m['throughput_kbps']:.2f} Kbps")
    print(f"Jitter               : {m['jitter_ms']:.4f} ms")
    print("==============================\n")


def print_table(rows):
    print("\n" + "=" * 86)
    print("  NS2 PERFORMANCE ANALYSIS — COMPARISON")
    print("=" * 86)
    print(f"{'Protocol':<10}{'Nodes':>7}{'Sent':>8}{'Recv':>8}"
          f"{'PDR (%)':>10}{'Delay (ms)':>13}{'Thr (Kbps)':>13}{'Jitter (ms)':>14}")
    print("-" * 86)
    for r in rows:
        print(f"{r['Protocol']:<10}{str(r['Nodes']):>7}{r['Sent']:>8}{r['Received']:>8}"
              f"{r['PDR (%)']:>10.2f}{r['Avg Delay (ms)']:>13.4f}"
              f"{r['Throughput (Kbps)']:>13.2f}{r['Jitter (ms)']:>14.4f}")
    print("=" * 86 + "\n")


# =================================================================
# 6. BAR CHARTS
# =================================================================
METRICS = [
    ("Throughput (Kbps)", "throughput", "Average Throughput", "Throughput (Kbps)", "#2E86AB"),
    ("Avg Delay (ms)",    "delay",      "Average End-to-End Delay", "Delay (ms)",   "#E4572E"),
    ("PDR (%)",           "pdr",        "Packet Delivery Ratio",    "PDR (%)",      "#3CAEA3"),
    ("Jitter (ms)",       "jitter",     "Jitter",                   "Jitter (ms)",  "#8E6C8A"),
]


def _annotate(ax, bars, fmt="{:.2f}"):
    for b in bars:
        h = b.get_height()
        ax.annotate(fmt.format(h), xy=(b.get_x() + b.get_width() / 2, h),
                    xytext=(0, 3), textcoords="offset points",
                    ha="center", va="bottom", fontsize=9)


def make_bar_charts(rows, out_dir="graphs"):
    if not HAVE_MPL:
        print("matplotlib not installed — skipping graphs (pip3 install matplotlib)")
        return
    os.makedirs(out_dir, exist_ok=True)

    labels = [make_label(r["Protocol"], r["Nodes"]) for r in rows]
    single = len(rows) == 1
    prefix = (labels[0].replace("-", "_") + "_") if single else "compare_"

    # ---- one PNG per metric -------------------------------------
    for col, fname, title, ylabel, color in METRICS:
        vals = [r[col] for r in rows]
        fig, ax = plt.subplots(figsize=(4.5, 5) if single else (max(6, 1.4 * len(rows)), 5))
        bars = ax.bar(labels, vals, color=color,
                      width=0.4 if single else 0.6, edgecolor="black", linewidth=0.6)
        _annotate(ax, bars)
        ax.set_title(title, fontsize=13, fontweight="bold")
        ax.set_ylabel(ylabel)
        ax.set_xlabel("Protocol / Nodes")
        ax.grid(axis="y", linestyle="--", alpha=0.4)
        ax.set_axisbelow(True)
        if vals and max(vals) > 0:
            ax.set_ylim(0, max(vals) * 1.18)
        if not single:
            plt.xticks(rotation=30, ha="right")
        plt.tight_layout()
        p = os.path.join(out_dir, f"{prefix}{fname}.png")
        plt.savefig(p, dpi=150)
        plt.close()
        print(f"Saved graph: {p}")

    # ---- combined 2x2 summary sheet ------------------------------
    fig, axes = plt.subplots(2, 2, figsize=(7, 8) if single else (max(11, 2.2 * len(rows)), 9))
    for ax, (col, _, title, ylabel, color) in zip(axes.flat, METRICS):
        vals = [r[col] for r in rows]
        bars = ax.bar(labels, vals, color=color,
                      width=0.4 if single else 0.6, edgecolor="black", linewidth=0.6)
        _annotate(ax, bars)
        ax.set_title(title, fontsize=11, fontweight="bold")
        ax.set_ylabel(ylabel, fontsize=9)
        ax.grid(axis="y", linestyle="--", alpha=0.4)
        ax.set_axisbelow(True)
        if vals and max(vals) > 0:
            ax.set_ylim(0, max(vals) * 1.18)
        if not single:
            ax.tick_params(axis="x", rotation=30, labelsize=8)
    head = labels[0] if single else "Protocol Comparison"
    fig.suptitle(f"NS2 Performance Analysis — {head}", fontsize=14, fontweight="bold")
    plt.tight_layout(rect=[0, 0, 1, 0.96])
    p = os.path.join(out_dir, f"{prefix}summary.png")
    plt.savefig(p, dpi=150)
    plt.close()
    print(f"Saved graph: {p}")


# =================================================================
# 7. CSV
# =================================================================
def save_csv(rows, path):
    if not rows:
        return
    import csv
    with open(path, "w", newline="") as fh:
        w = csv.DictWriter(fh, fieldnames=list(rows[0].keys()))
        w.writeheader()
        w.writerows(rows)
    print(f"Saved: {path}")


# =================================================================
# 8. MAIN
# =================================================================
def main():
    ap = argparse.ArgumentParser(
        description="NS-2 trace analyzer — PDR, Delay, Throughput, Jitter.")
    ap.add_argument("--files", nargs="*", help="Explicit .tr files to analyze")
    ap.add_argument("--dir", default=".", help="Directory to scan for *.tr (default: .)")
    ap.add_argument("--pkt-types", default=None,
                    help="Comma list of app packet types to count, e.g. 'tcp' or 'cbr'. "
                         "Default: every AGT-level packet (tcp+ack, or cbr).")
    ap.add_argument("--csv", default="results.csv", help="Output CSV path")
    ap.add_argument("--graphs-dir", default="graphs", help="Directory for PNG charts")
    ap.add_argument("--no-graphs", action="store_true", help="Skip chart generation")
    args = ap.parse_args()

    # Be forgiving if the user typed commas:  --files a.tr, b.tr
    if args.files:
        files = [f.strip().rstrip(",") for f in args.files if f.strip().strip(",")]
    else:
        files = sorted(glob.glob(os.path.join(args.dir, "*.tr")))

    files = [f for f in files if f]
    missing = [f for f in files if not os.path.isfile(f)]
    for f in missing:
        print(f"WARNING: file not found -> {f}")
    files = [f for f in files if os.path.isfile(f)]

    if not files:
        print("No .tr files to analyze. Use --files or --dir.")
        sys.exit(1)

    pkt_filter = None
    if args.pkt_types:
        pkt_filter = {p.strip().lower() for p in args.pkt_types.split(",") if p.strip()}

    rows = []
    for path in files:
        proto, nodes = detect_protocol_and_nodes(path)
        m = analyze(path, pkt_filter)
        if len(files) > 1:
            print(f"Analyzed {os.path.basename(path)} "
                  f"[{m['format']} format, protocol={proto}, nodes={nodes}]")
        rows.append({
            "File": os.path.basename(path),
            "Protocol": proto,
            "Nodes": nodes,
            "Sent": m["sent"],
            "Received": m["received"],
            "PDR (%)": round(m["pdr"], 2),
            "Avg Delay (ms)": round(m["avg_delay_ms"], 4),
            "Throughput (Kbps)": round(m["throughput_kbps"], 2),
            "Jitter (ms)": round(m["jitter_ms"], 4),
            "Sim Time (s)": round(m["sim_time"], 2),
        })
        if len(files) == 1:
            print_single(m)

    if len(files) > 1:
        print_table(rows)

    save_csv(rows, args.csv)
    if not args.no_graphs:
        make_bar_charts(rows, args.graphs_dir)


if __name__ == "__main__":
    main()
