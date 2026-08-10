# This script is created by NSG2 beta1
# <http://wushoupong.googlepages.com/nsg>

#===================================
#     Simulation parameters setup
#===================================
set val(chan)   Channel/WirelessChannel    ;# channel type
set val(prop)   Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)  Phy/WirelessPhy            ;# network interface type
set val(mac)    Mac/802_11                 ;# MAC type
set val(ifq)    Queue/DropTail/PriQueue    ;# interface queue type
set val(ll)     LL                         ;# link layer type
set val(ant)    Antenna/OmniAntenna        ;# antenna model
set val(ifqlen) 50                         ;# max packet in ifq
set val(nn)     50                         ;# number of mobilenodes
set val(rp)     DSDV                       ;# routing protocol
set val(x)      1000                      ;# X dimension of topography
set val(y)      1000                     ;# Y dimension of topography
set val(stop)   100.0                         ;# time of simulation end

#===================================
#        Initialization        
#===================================
#Create a ns simulator
set ns [new Simulator]
$ns use-newtrace;

#Setup topography object
set topo       [new Topography]
$topo load_flatgrid $val(x) $val(y)
create-god $val(nn)

#Open the NS trace file
set tracefile [open DSDV_50.tr w]
$ns trace-all $tracefile

#Open the NAM trace file
set namfile [open DSDV_50.nam w]
$ns namtrace-all $namfile
$ns namtrace-all-wireless $namfile $val(x) $val(y)
set chan [new $val(chan)];#Create wireless channel

#===================================
#     Mobile node parameter setup
#===================================
$ns node-config -adhocRouting  $val(rp) \
                -llType        $val(ll) \
                -macType       $val(mac) \
                -ifqType       $val(ifq) \
                -ifqLen        $val(ifqlen) \
                -antType       $val(ant) \
                -propType      $val(prop) \
                -phyType       $val(netif) \
                -channel       $chan \
                -topoInstance  $topo \
                -agentTrace    ON \
                -routerTrace   ON \
                -macTrace      ON \
                -movementTrace ON

#===================================
#        Nodes Definition
#===================================
set n0 [$ns node]
$n0 set X_ 239
$n0 set Y_ 755
$n0 set Z_ 0.0
$ns initial_node_pos $n0 20
set n1 [$ns node]
$n1 set X_ 699
$n1 set Y_ 552
$n1 set Z_ 0.0
$ns initial_node_pos $n1 20
set n2 [$ns node]
$n2 set X_ 167
$n2 set Y_ 334
$n2 set Z_ 0.0
$ns initial_node_pos $n2 20
set n3 [$ns node]
$n3 set X_ 249
$n3 set Y_ 68
$n3 set Z_ 0.0
$ns initial_node_pos $n3 20
set n4 [$ns node]
$n4 set X_ 757
$n4 set Y_ 168
$n4 set Z_ 0.0
$ns initial_node_pos $n4 20
set n5 [$ns node]
$n5 set X_ 106
$n5 set Y_ 63
$n5 set Z_ 0.0
$ns initial_node_pos $n5 20
set n6 [$ns node]
$n6 set X_ 99
$n6 set Y_ 629
$n6 set Z_ 0.0
$ns initial_node_pos $n6 20
set n7 [$ns node]
$n7 set X_ 650
$n7 set Y_ 875
$n7 set Z_ 0.0
$ns initial_node_pos $n7 20
set n8 [$ns node]
$n8 set X_ 712
$n8 set Y_ 126
$n8 set Z_ 0.0
$ns initial_node_pos $n8 20
set n9 [$ns node]
$n9 set X_ 457
$n9 set Y_ 881
$n9 set Z_ 0.0
$ns initial_node_pos $n9 20
set n10 [$ns node]
$n10 set X_ 164
$n10 set Y_ 835
$n10 set Z_ 0.0
$ns initial_node_pos $n10 20
set n11 [$ns node]
$n11 set X_ 199
$n11 set Y_ 209
$n11 set Z_ 0.0
$ns initial_node_pos $n11 20
set n12 [$ns node]
$n12 set X_ 459
$n12 set Y_ 376
$n12 set Z_ 0.0
$ns initial_node_pos $n12 20
set n13 [$ns node]
$n13 set X_ 149
$n13 set Y_ 661
$n13 set Z_ 0.0
$ns initial_node_pos $n13 20
set n14 [$ns node]
$n14 set X_ 919
$n14 set Y_ 882
$n14 set Z_ 0.0
$ns initial_node_pos $n14 20
set n15 [$ns node]
$n15 set X_ 230
$n15 set Y_ 633
$n15 set Z_ 0.0
$ns initial_node_pos $n15 20
set n16 [$ns node]
$n16 set X_ 116
$n16 set Y_ 847
$n16 set Z_ 0.0
$ns initial_node_pos $n16 20
set n17 [$ns node]
$n17 set X_ 506
$n17 set Y_ 68
$n17 set Z_ 0.0
$ns initial_node_pos $n17 20
set n18 [$ns node]
$n18 set X_ 424
$n18 set Y_ 325
$n18 set Z_ 0.0
$ns initial_node_pos $n18 20
set n19 [$ns node]
$n19 set X_ 361
$n19 set Y_ 924
$n19 set Z_ 0.0
$ns initial_node_pos $n19 20
set n20 [$ns node]
$n20 set X_ 922
$n20 set Y_ 99
$n20 set Z_ 0.0
$ns initial_node_pos $n20 20
set n21 [$ns node]
$n21 set X_ 270
$n21 set Y_ 304
$n21 set Z_ 0.0
$ns initial_node_pos $n21 20
set n22 [$ns node]
$n22 set X_ 245
$n22 set Y_ 872
$n22 set Z_ 0.0
$ns initial_node_pos $n22 20
set n23 [$ns node]
$n23 set X_ 831
$n23 set Y_ 947
$n23 set Z_ 0.0
$ns initial_node_pos $n23 20
set n24 [$ns node]
$n24 set X_ 891
$n24 set Y_ 165
$n24 set Z_ 0.0
$ns initial_node_pos $n24 20
set n25 [$ns node]
$n25 set X_ 804
$n25 set Y_ 203
$n25 set Z_ 0.0
$ns initial_node_pos $n25 20
set n26 [$ns node]
$n26 set X_ 676
$n26 set Y_ 796
$n26 set Z_ 0.0
$ns initial_node_pos $n26 20
set n27 [$ns node]
$n27 set X_ 664
$n27 set Y_ 305
$n27 set Z_ 0.0
$ns initial_node_pos $n27 20
set n28 [$ns node]
$n28 set X_ 63
$n28 set Y_ 78
$n28 set Z_ 0.0
$ns initial_node_pos $n28 20
set n29 [$ns node]
$n29 set X_ 708
$n29 set Y_ 619
$n29 set Z_ 0.0
$ns initial_node_pos $n29 20
set n30 [$ns node]
$n30 set X_ 811
$n30 set Y_ 739
$n30 set Z_ 0.0
$ns initial_node_pos $n30 20
set n31 [$ns node]
$n31 set X_ 72
$n31 set Y_ 674
$n31 set Z_ 0.0
$ns initial_node_pos $n31 20
set n32 [$ns node]
$n32 set X_ 605
$n32 set Y_ 424
$n32 set Z_ 0.0
$ns initial_node_pos $n32 20
set n33 [$ns node]
$n33 set X_ 340
$n33 set Y_ 882
$n33 set Z_ 0.0
$ns initial_node_pos $n33 20
set n34 [$ns node]
$n34 set X_ 347
$n34 set Y_ 314
$n34 set Z_ 0.0
$ns initial_node_pos $n34 20
set n35 [$ns node]
$n35 set X_ 621
$n35 set Y_ 157
$n35 set Z_ 0.0
$ns initial_node_pos $n35 20
set n36 [$ns node]
$n36 set X_ 772
$n36 set Y_ 55
$n36 set Z_ 0.0
$ns initial_node_pos $n36 20
set n37 [$ns node]
$n37 set X_ 408
$n37 set Y_ 141
$n37 set Z_ 0.0
$ns initial_node_pos $n37 20
set n38 [$ns node]
$n38 set X_ 881
$n38 set Y_ 488
$n38 set Z_ 0.0
$ns initial_node_pos $n38 20
set n39 [$ns node]
$n39 set X_ 772
$n39 set Y_ 820
$n39 set Z_ 0.0
$ns initial_node_pos $n39 20
set n40 [$ns node]
$n40 set X_ 325
$n40 set Y_ 636
$n40 set Z_ 0.0
$ns initial_node_pos $n40 20
set n41 [$ns node]
$n41 set X_ 932
$n41 set Y_ 40
$n41 set Z_ 0.0
$ns initial_node_pos $n41 20
set n42 [$ns node]
$n42 set X_ 69
$n42 set Y_ 952
$n42 set Z_ 0.0
$ns initial_node_pos $n42 20
set n43 [$ns node]
$n43 set X_ 123
$n43 set Y_ 115
$n43 set Z_ 0.0
$ns initial_node_pos $n43 20
set n44 [$ns node]
$n44 set X_ 570
$n44 set Y_ 334
$n44 set Z_ 0.0
$ns initial_node_pos $n44 20
set n45 [$ns node]
$n45 set X_ 754
$n45 set Y_ 308
$n45 set Z_ 0.0
$ns initial_node_pos $n45 20
set n46 [$ns node]
$n46 set X_ 824
$n46 set Y_ 612
$n46 set Z_ 0.0
$ns initial_node_pos $n46 20
set n47 [$ns node]
$n47 set X_ 899
$n47 set Y_ 624
$n47 set Z_ 0.0
$ns initial_node_pos $n47 20
set n48 [$ns node]
$n48 set X_ 691
$n48 set Y_ 444
$n48 set Z_ 0.0
$ns initial_node_pos $n48 20
set n49 [$ns node]
$n49 set X_ 863
$n49 set Y_ 397
$n49 set Z_ 0.0
$ns initial_node_pos $n49 20

#===================================
#        Mobility (random waypoint)
#===================================
# node 9 — 4 waypoints
$ns at 2 "$n9 setdest 554 782 14"
$ns at 14 "$n9 setdest 492 920 15"
$ns at 26 "$n9 setdest 583 826 13"
$ns at 38 "$n9 setdest 508 920 12"

# node 26 — 4 waypoints
$ns at 2 "$n26 setdest 682 920 13"
$ns at 14 "$n26 setdest 749 797 13"
$ns at 26 "$n26 setdest 745 920 13"
$ns at 38 "$n26 setdest 611 920 14"

# node 1 — 4 waypoints
$ns at 2 "$n1 setdest 792 659 14"
$ns at 14 "$n1 setdest 920 635 12"
$ns at 26 "$n1 setdest 920 515 15"
$ns at 38 "$n1 setdest 832 616 14"

# node 27 — 4 waypoints
$ns at 2 "$n27 setdest 573 221 12"
$ns at 14 "$n27 setdest 493 324 14"
$ns at 26 "$n27 setdest 484 199 13"
$ns at 38 "$n27 setdest 502 80 15"

#===================================
#        Agents Definition
#===================================

# TCP Flow 1 :  n0 --> n49
set tcp0 [new Agent/TCP]
$tcp0 set packetSize_ 512
$ns attach-agent $n0 $tcp0
set sink0 [new Agent/TCPSink]
$ns attach-agent $n49 $sink0
$ns connect $tcp0 $sink0

# TCP Flow 2 :  n5 --> n42
set tcp1 [new Agent/TCP]
$tcp1 set packetSize_ 512
$ns attach-agent $n5 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n42 $sink1
$ns connect $tcp1 $sink1

# TCP Flow 3 :  n10 --> n35
set tcp2 [new Agent/TCP]
$tcp2 set packetSize_ 512
$ns attach-agent $n10 $tcp2
set sink2 [new Agent/TCPSink]
$ns attach-agent $n35 $sink2
$ns connect $tcp2 $sink2

# TCP Flow 4 :  n15 --> n28
set tcp3 [new Agent/TCP]
$tcp3 set packetSize_ 512
$ns attach-agent $n15 $tcp3
set sink3 [new Agent/TCPSink]
$ns attach-agent $n28 $sink3
$ns connect $tcp3 $sink3

# TCP Flow 5 :  n20 --> n40
set tcp4 [new Agent/TCP]
$tcp4 set packetSize_ 512
$ns attach-agent $n20 $tcp4
set sink4 [new Agent/TCPSink]
$ns attach-agent $n40 $sink4
$ns connect $tcp4 $sink4

#===================================
#        Applications Definition
#===================================

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns at 5.0 "$ftp0 start"
$ns at 95.0 "$ftp0 stop"

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ns at 5.0 "$ftp1 start"
$ns at 95.0 "$ftp1 stop"

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
$ns at 5.0 "$ftp2 start"
$ns at 95.0 "$ftp2 stop"

set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcp3
$ns at 5.0 "$ftp3 start"
$ns at 95.0 "$ftp3 stop"

set ftp4 [new Application/FTP]
$ftp4 attach-agent $tcp4
$ns at 5.0 "$ftp4 start"
$ns at 95.0 "$ftp4 stop"

#===================================
#        Termination        
#===================================
#Define a 'finish' procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam DSDV_50.nam &
    exit 0
}
for {set i 0} {$i < $val(nn) } { incr i } {
    $ns at $val(stop) "\$n$i reset"
}
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run
