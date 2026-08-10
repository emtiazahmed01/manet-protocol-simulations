# This script is created by NSG2 beta1
# <http://wushoupong.googlepages.com/nsg>

#===================================
#     Simulation parameters setup
#===================================
set val(chan)   Channel/WirelessChannel    ;# channel type
set val(prop)   Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)  Phy/WirelessPhy            ;# network interface type
set val(mac)    Mac/802_11                 ;# MAC type
set val(ifq)    CMUPriQueue    ;# interface queue type
set val(ll)     LL                         ;# link layer type
set val(ant)    Antenna/OmniAntenna        ;# antenna model
set val(ifqlen) 50                         ;# max packet in ifq
set val(nn)     75                         ;# number of mobilenodes
set val(rp)     DSR                       ;# routing protocol
set val(x)      1000                       ;# X dimension of topography
set val(y)      1000                       ;# Y dimension of topography
set val(stop)   100.0                      ;# time of simulation end

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
set tracefile [open DSR_75.tr w]
$ns trace-all $tracefile

#Open the NAM trace file
set namfile [open DSR_75.nam w]
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
#Create 75 nodes
set n0 [$ns node]
$n0 set X_ 778
$n0 set Y_ 338
$n0 set Z_ 0.0
$ns initial_node_pos $n0 20
set n1 [$ns node]
$n1 set X_ 259
$n1 set Y_ 800
$n1 set Z_ 0.0
$ns initial_node_pos $n1 20
set n2 [$ns node]
$n2 set X_ 142
$n2 set Y_ 478
$n2 set Z_ 0.0
$ns initial_node_pos $n2 20
set n3 [$ns node]
$n3 set X_ 554
$n3 set Y_ 604
$n3 set Z_ 0.0
$ns initial_node_pos $n3 20
set n4 [$ns node]
$n4 set X_ 170
$n4 set Y_ 622
$n4 set Z_ 0.0
$ns initial_node_pos $n4 20
set n5 [$ns node]
$n5 set X_ 501
$n5 set Y_ 827
$n5 set Z_ 0.0
$ns initial_node_pos $n5 20
set n6 [$ns node]
$n6 set X_ 61
$n6 set Y_ 925
$n6 set Z_ 0.0
$ns initial_node_pos $n6 20
set n7 [$ns node]
$n7 set X_ 196
$n7 set Y_ 791
$n7 set Z_ 0.0
$ns initial_node_pos $n7 20
set n8 [$ns node]
$n8 set X_ 205
$n8 set Y_ 334
$n8 set Z_ 0.0
$ns initial_node_pos $n8 20
set n9 [$ns node]
$n9 set X_ 116
$n9 set Y_ 759
$n9 set Z_ 0.0
$ns initial_node_pos $n9 20
set n10 [$ns node]
$n10 set X_ 532
$n10 set Y_ 226
$n10 set Z_ 0.0
$ns initial_node_pos $n10 20
set n11 [$ns node]
$n11 set X_ 213
$n11 set Y_ 110
$n11 set Z_ 0.0
$ns initial_node_pos $n11 20
set n12 [$ns node]
$n12 set X_ 221
$n12 set Y_ 556
$n12 set Z_ 0.0
$ns initial_node_pos $n12 20
set n13 [$ns node]
$n13 set X_ 442
$n13 set Y_ 690
$n13 set Z_ 0.0
$ns initial_node_pos $n13 20
set n14 [$ns node]
$n14 set X_ 106
$n14 set Y_ 816
$n14 set Z_ 0.0
$ns initial_node_pos $n14 20
set n15 [$ns node]
$n15 set X_ 948
$n15 set Y_ 723
$n15 set Z_ 0.0
$ns initial_node_pos $n15 20
set n16 [$ns node]
$n16 set X_ 726
$n16 set Y_ 825
$n16 set Z_ 0.0
$ns initial_node_pos $n16 20
set n17 [$ns node]
$n17 set X_ 535
$n17 set Y_ 134
$n17 set Z_ 0.0
$ns initial_node_pos $n17 20
set n18 [$ns node]
$n18 set X_ 449
$n18 set Y_ 757
$n18 set Z_ 0.0
$ns initial_node_pos $n18 20
set n19 [$ns node]
$n19 set X_ 906
$n19 set Y_ 87
$n19 set Z_ 0.0
$ns initial_node_pos $n19 20
set n20 [$ns node]
$n20 set X_ 819
$n20 set Y_ 941
$n20 set Z_ 0.0
$ns initial_node_pos $n20 20
set n21 [$ns node]
$n21 set X_ 733
$n21 set Y_ 915
$n21 set Z_ 0.0
$ns initial_node_pos $n21 20
set n22 [$ns node]
$n22 set X_ 474
$n22 set Y_ 721
$n22 set Z_ 0.0
$ns initial_node_pos $n22 20
set n23 [$ns node]
$n23 set X_ 750
$n23 set Y_ 392
$n23 set Z_ 0.0
$ns initial_node_pos $n23 20
set n24 [$ns node]
$n24 set X_ 496
$n24 set Y_ 72
$n24 set Z_ 0.0
$ns initial_node_pos $n24 20
set n25 [$ns node]
$n25 set X_ 368
$n25 set Y_ 955
$n25 set Z_ 0.0
$ns initial_node_pos $n25 20
set n26 [$ns node]
$n26 set X_ 145
$n26 set Y_ 952
$n26 set Z_ 0.0
$ns initial_node_pos $n26 20
set n27 [$ns node]
$n27 set X_ 877
$n27 set Y_ 675
$n27 set Z_ 0.0
$ns initial_node_pos $n27 20
set n28 [$ns node]
$n28 set X_ 87
$n28 set Y_ 474
$n28 set Z_ 0.0
$ns initial_node_pos $n28 20
set n29 [$ns node]
$n29 set X_ 679
$n29 set Y_ 124
$n29 set Z_ 0.0
$ns initial_node_pos $n29 20
set n30 [$ns node]
$n30 set X_ 312
$n30 set Y_ 120
$n30 set Z_ 0.0
$ns initial_node_pos $n30 20
set n31 [$ns node]
$n31 set X_ 819
$n31 set Y_ 886
$n31 set Z_ 0.0
$ns initial_node_pos $n31 20
set n32 [$ns node]
$n32 set X_ 894
$n32 set Y_ 733
$n32 set Z_ 0.0
$ns initial_node_pos $n32 20
set n33 [$ns node]
$n33 set X_ 570
$n33 set Y_ 93
$n33 set Z_ 0.0
$ns initial_node_pos $n33 20
set n34 [$ns node]
$n34 set X_ 738
$n34 set Y_ 60
$n34 set Z_ 0.0
$ns initial_node_pos $n34 20
set n35 [$ns node]
$n35 set X_ 43
$n35 set Y_ 117
$n35 set Z_ 0.0
$ns initial_node_pos $n35 20
set n36 [$ns node]
$n36 set X_ 895
$n36 set Y_ 141
$n36 set Z_ 0.0
$ns initial_node_pos $n36 20
set n37 [$ns node]
$n37 set X_ 398
$n37 set Y_ 478
$n37 set Z_ 0.0
$ns initial_node_pos $n37 20
set n38 [$ns node]
$n38 set X_ 857
$n38 set Y_ 161
$n38 set Z_ 0.0
$ns initial_node_pos $n38 20
set n39 [$ns node]
$n39 set X_ 278
$n39 set Y_ 753
$n39 set Z_ 0.0
$ns initial_node_pos $n39 20
set n40 [$ns node]
$n40 set X_ 115
$n40 set Y_ 188
$n40 set Z_ 0.0
$ns initial_node_pos $n40 20
set n41 [$ns node]
$n41 set X_ 252
$n41 set Y_ 501
$n41 set Z_ 0.0
$ns initial_node_pos $n41 20
set n42 [$ns node]
$n42 set X_ 697
$n42 set Y_ 594
$n42 set Z_ 0.0
$ns initial_node_pos $n42 20
set n43 [$ns node]
$n43 set X_ 490
$n43 set Y_ 284
$n43 set Z_ 0.0
$ns initial_node_pos $n43 20
set n44 [$ns node]
$n44 set X_ 815
$n44 set Y_ 131
$n44 set Z_ 0.0
$ns initial_node_pos $n44 20
set n45 [$ns node]
$n45 set X_ 613
$n45 set Y_ 309
$n45 set Z_ 0.0
$ns initial_node_pos $n45 20
set n46 [$ns node]
$n46 set X_ 292
$n46 set Y_ 457
$n46 set Z_ 0.0
$ns initial_node_pos $n46 20
set n47 [$ns node]
$n47 set X_ 101
$n47 set Y_ 52
$n47 set Z_ 0.0
$ns initial_node_pos $n47 20
set n48 [$ns node]
$n48 set X_ 166
$n48 set Y_ 119
$n48 set Z_ 0.0
$ns initial_node_pos $n48 20
set n49 [$ns node]
$n49 set X_ 852
$n49 set Y_ 510
$n49 set Z_ 0.0
$ns initial_node_pos $n49 20
set n50 [$ns node]
$n50 set X_ 666
$n50 set Y_ 760
$n50 set Z_ 0.0
$ns initial_node_pos $n50 20
set n51 [$ns node]
$n51 set X_ 189
$n51 set Y_ 920
$n51 set Z_ 0.0
$ns initial_node_pos $n51 20
set n52 [$ns node]
$n52 set X_ 489
$n52 set Y_ 682
$n52 set Z_ 0.0
$ns initial_node_pos $n52 20
set n53 [$ns node]
$n53 set X_ 750
$n53 set Y_ 215
$n53 set Z_ 0.0
$ns initial_node_pos $n53 20
set n54 [$ns node]
$n54 set X_ 805
$n54 set Y_ 433
$n54 set Z_ 0.0
$ns initial_node_pos $n54 20
set n55 [$ns node]
$n55 set X_ 846
$n55 set Y_ 833
$n55 set Z_ 0.0
$ns initial_node_pos $n55 20
set n56 [$ns node]
$n56 set X_ 336
$n56 set Y_ 885
$n56 set Z_ 0.0
$ns initial_node_pos $n56 20
set n57 [$ns node]
$n57 set X_ 737
$n57 set Y_ 965
$n57 set Z_ 0.0
$ns initial_node_pos $n57 20
set n58 [$ns node]
$n58 set X_ 762
$n58 set Y_ 523
$n58 set Z_ 0.0
$ns initial_node_pos $n58 20
set n59 [$ns node]
$n59 set X_ 504
$n59 set Y_ 407
$n59 set Z_ 0.0
$ns initial_node_pos $n59 20
set n60 [$ns node]
$n60 set X_ 843
$n60 set Y_ 387
$n60 set Z_ 0.0
$ns initial_node_pos $n60 20
set n61 [$ns node]
$n61 set X_ 729
$n61 set Y_ 558
$n61 set Z_ 0.0
$ns initial_node_pos $n61 20
set n62 [$ns node]
$n62 set X_ 692
$n62 set Y_ 323
$n62 set Z_ 0.0
$ns initial_node_pos $n62 20
set n63 [$ns node]
$n63 set X_ 108
$n63 set Y_ 663
$n63 set Z_ 0.0
$ns initial_node_pos $n63 20
set n64 [$ns node]
$n64 set X_ 170
$n64 set Y_ 369
$n64 set Z_ 0.0
$ns initial_node_pos $n64 20
set n65 [$ns node]
$n65 set X_ 882
$n65 set Y_ 583
$n65 set Z_ 0.0
$ns initial_node_pos $n65 20
set n66 [$ns node]
$n66 set X_ 557
$n66 set Y_ 665
$n66 set Z_ 0.0
$ns initial_node_pos $n66 20
set n67 [$ns node]
$n67 set X_ 630
$n67 set Y_ 801
$n67 set Z_ 0.0
$ns initial_node_pos $n67 20
set n68 [$ns node]
$n68 set X_ 287
$n68 set Y_ 185
$n68 set Z_ 0.0
$ns initial_node_pos $n68 20
set n69 [$ns node]
$n69 set X_ 457
$n69 set Y_ 612
$n69 set Z_ 0.0
$ns initial_node_pos $n69 20
set n70 [$ns node]
$n70 set X_ 824
$n70 set Y_ 79
$n70 set Z_ 0.0
$ns initial_node_pos $n70 20
set n71 [$ns node]
$n71 set X_ 731
$n71 set Y_ 173
$n71 set Z_ 0.0
$ns initial_node_pos $n71 20
set n72 [$ns node]
$n72 set X_ 411
$n72 set Y_ 948
$n72 set Z_ 0.0
$ns initial_node_pos $n72 20
set n73 [$ns node]
$n73 set X_ 39
$n73 set Y_ 64
$n73 set Z_ 0.0
$ns initial_node_pos $n73 20
set n74 [$ns node]
$n74 set X_ 765
$n74 set Y_ 786
$n74 set Z_ 0.0
$ns initial_node_pos $n74 20

#===================================
#        Mobility (random waypoint)
#===================================

$ns at 30 "$n3 setdest 631 475 14"
$ns at 45 "$n3 setdest 518 555 12"
$ns at 60 "$n3 setdest 677 518 12"
$ns at 75 "$n3 setdest 579 614 11"
$ns at 90 "$n3 setdest 692 469 15"

# node 5 - 5 waypoints
$ns at 30 "$n5 setdest 420 950 15"
$ns at 45 "$n5 setdest 270 849 15"
$ns at 60 "$n5 setdest 162 950 13"
$ns at 75 "$n5 setdest 294 950 11"
$ns at 90 "$n5 setdest 426 950 10"

# node 12 - 5 waypoints
$ns at 30 "$n12 setdest 90 539 12"
$ns at 45 "$n12 setdest 279 462 15"
$ns at 60 "$n12 setdest 422 452 13"
$ns at 75 "$n12 setdest 325 578 13"
$ns at 90 "$n12 setdest 450 646 14"

# node 37 - 5 waypoints
$ns at 30 "$n37 setdest 425 304 14"
$ns at 45 "$n37 setdest 496 452 14"
$ns at 60 "$n37 setdest 344 491 12"
$ns at 75 "$n37 setdest 305 357 11"
$ns at 90 "$n37 setdest 122 327 15"

#===================================
#        Agents Definition
#===================================

# TCP Flow 1 :  n45 --> n26
set tcp0 [new Agent/TCP]
$tcp0 set packetSize_ 512
$ns attach-agent $n45 $tcp0
set sink0 [new Agent/TCPSink]
$ns attach-agent $n26 $sink0
$ns connect $tcp0 $sink0

# TCP Flow 2 :  n29 --> n73
set tcp1 [new Agent/TCP]
$tcp1 set packetSize_ 512
$ns attach-agent $n29 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n73 $sink1
$ns connect $tcp1 $sink1

# TCP Flow 3 :  n7 --> n49
set tcp2 [new Agent/TCP]
$tcp2 set packetSize_ 512
$ns attach-agent $n7 $tcp2
set sink2 [new Agent/TCPSink]
$ns attach-agent $n49 $sink2
$ns connect $tcp2 $sink2

# TCP Flow 4 :  n58 --> n40
set tcp3 [new Agent/TCP]
$tcp3 set packetSize_ 512
$ns attach-agent $n58 $tcp3
set sink3 [new Agent/TCPSink]
$ns attach-agent $n40 $sink3
$ns connect $tcp3 $sink3

# TCP Flow 5 :  n38 --> n13
set tcp4 [new Agent/TCP]
$tcp4 set packetSize_ 512
$ns attach-agent $n38 $tcp4
set sink4 [new Agent/TCPSink]
$ns attach-agent $n13 $sink4
$ns connect $tcp4 $sink4

# TCP Flow 6 :  n1 --> n54
set tcp5 [new Agent/TCP]
$tcp5 set packetSize_ 512
$ns attach-agent $n1 $tcp5
set sink5 [new Agent/TCPSink]
$ns attach-agent $n54 $sink5
$ns connect $tcp5 $sink5

# TCP Flow 7 :  n44 --> n9
set tcp6 [new Agent/TCP]
$tcp6 set packetSize_ 512
$ns attach-agent $n44 $tcp6
set sink6 [new Agent/TCPSink]
$ns attach-agent $n9 $sink6
$ns connect $tcp6 $sink6

# TCP Flow 8 :  n28 --> n16
set tcp7 [new Agent/TCP]
$tcp7 set packetSize_ 512
$ns attach-agent $n28 $tcp7
set sink7 [new Agent/TCPSink]
$ns attach-agent $n16 $sink7
$ns connect $tcp7 $sink7

#===================================
#        Applications Definition
#===================================

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns at 25.0 "$ftp0 start"
$ns at 95.0 "$ftp0 stop"

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ns at 26.0 "$ftp1 start"
$ns at 95.0 "$ftp1 stop"

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
$ns at 27.0 "$ftp2 start"
$ns at 95.0 "$ftp2 stop"

set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcp3
$ns at 28.0 "$ftp3 start"
$ns at 95.0 "$ftp3 stop"

set ftp4 [new Application/FTP]
$ftp4 attach-agent $tcp4
$ns at 29.0 "$ftp4 start"
$ns at 95.0 "$ftp4 stop"

set ftp5 [new Application/FTP]
$ftp5 attach-agent $tcp5
$ns at 30.0 "$ftp5 start"
$ns at 95.0 "$ftp5 stop"

set ftp6 [new Application/FTP]
$ftp6 attach-agent $tcp6
$ns at 31.0 "$ftp6 start"
$ns at 95.0 "$ftp6 stop"

set ftp7 [new Application/FTP]
$ftp7 attach-agent $tcp7
$ns at 32.0 "$ftp7 start"
$ns at 95.0 "$ftp7 stop"

#===================================
#        Termination        
#===================================
#Define a 'finish' procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam DSR_75.nam &
    exit 0
}
for {set i 0} {$i < $val(nn) } { incr i } {
    $ns at $val(stop) "\$n$i reset"
}

$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run
