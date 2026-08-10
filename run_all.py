#!/usr/bin/env python3

import subprocess
import pathlib
import time

# Folder containing the .tcl files
WORK_DIR = pathlib.Path(".")

# Find all TCL files
tcl_files = sorted(WORK_DIR.glob("*.tcl"))

if not tcl_files:
    print("No TCL files found.")
    exit()

print("="*60)
print(f"Found {len(tcl_files)} TCL files")
print("="*60)

success = []
failed = []

for tcl in tcl_files:

    print(f"\nRunning: {tcl.name}")

    start = time.time()

    try:

        result = subprocess.run(
            ["ns", str(tcl)],
            capture_output=True,
            text=True
        )

        runtime = time.time() - start

        if result.returncode == 0:

            print(f"SUCCESS ({runtime:.2f} sec)")
            success.append(tcl.name)

        else:

            print(f"FAILED ({runtime:.2f} sec)")
            print(result.stderr)
            failed.append(tcl.name)

    except Exception as e:

        print(e)
        failed.append(tcl.name)

print("\n")
print("="*60)
print("Simulation Summary")
print("="*60)

print("\nSuccessful")

for s in success:
    print("  ", s)

print("\nFailed")

for f in failed:
    print("  ", f)

print("\nDone.")
