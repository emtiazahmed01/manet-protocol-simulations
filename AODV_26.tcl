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
set val(nn)     26                         ;# number of mobilenodes
set val(rp)     AODV                       ;# routing protocol
set val(x)      2245                      ;# X dimension of topography
set val(y)      900                      ;# Y dimension of topography
set val(stop)   50.0                         ;# time of simulation end

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
set tracefile [open AODV_26.tr w]
$ns trace-all $tracefile

#Open the NAM trace file
set namfile [open AODV_26.nam w]
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
#Create 26 nodes
set n0 [$ns node]
$n0 set X_ 640
$n0 set Y_ 120
$n0 set Z_ 0.0
$ns initial_node_pos $n0 20
set n1 [$ns node]
$n1 set X_ 1061
$n1 set Y_ 471
$n1 set Z_ 0.0
$ns initial_node_pos $n1 20
set n2 [$ns node]
$n2 set X_ 1463
$n2 set Y_ 122
$n2 set Z_ 0.0
$ns initial_node_pos $n2 20
set n3 [$ns node]
$n3 set X_ 944
$n3 set Y_ 458
$n3 set Z_ 0.0
$ns initial_node_pos $n3 20
set n4 [$ns node]
$n4 set X_ 878
$n4 set Y_ 621
$n4 set Z_ 0.0
$ns initial_node_pos $n4 20
set n5 [$ns node]
$n5 set X_ 1389
$n5 set Y_ -5
$n5 set Z_ 0.0
$ns initial_node_pos $n5 20
set n6 [$ns node]
$n6 set X_ 1362
$n6 set Y_ 303
$n6 set Z_ 0.0
$ns initial_node_pos $n6 20
set n7 [$ns node]
$n7 set X_ 1405
$n7 set Y_ 36
$n7 set Z_ 0.0
$ns initial_node_pos $n7 20
set n8 [$ns node]
$n8 set X_ 929
$n8 set Y_ 465
$n8 set Z_ 0.0
$ns initial_node_pos $n8 20
set n9 [$ns node]
$n9 set X_ 859
$n9 set Y_ 373
$n9 set Z_ 0.0
$ns initial_node_pos $n9 20
set n10 [$ns node]
$n10 set X_ 693
$n10 set Y_ -25
$n10 set Z_ 0.0
$ns initial_node_pos $n10 20
set n11 [$ns node]
$n11 set X_ 868
$n11 set Y_ 604
$n11 set Z_ 0.0
$ns initial_node_pos $n11 20
set n12 [$ns node]
$n12 set X_ 1391
$n12 set Y_ -109
$n12 set Z_ 0.0
$ns initial_node_pos $n12 20
set n13 [$ns node]
$n13 set X_ 612
$n13 set Y_ 509
$n13 set Z_ 0.0
$ns initial_node_pos $n13 20
set n14 [$ns node]
$n14 set X_ 1248
$n14 set Y_ 457
$n14 set Z_ 0.0
$ns initial_node_pos $n14 20
set n15 [$ns node]
$n15 set X_ 1338
$n15 set Y_ 316
$n15 set Z_ 0.0
$ns initial_node_pos $n15 20
set n16 [$ns node]
$n16 set X_ 805
$n16 set Y_ 373
$n16 set Z_ 0.0
$ns initial_node_pos $n16 20
set n17 [$ns node]
$n17 set X_ 634
$n17 set Y_ -205
$n17 set Z_ 0.0
$ns initial_node_pos $n17 20
set n18 [$ns node]
$n18 set X_ 1052
$n18 set Y_ -221
$n18 set Z_ 0.0
$ns initial_node_pos $n18 20
set n19 [$ns node]
$n19 set X_ 1477
$n19 set Y_ 347
$n19 set Z_ 0.0
$ns initial_node_pos $n19 20
set n20 [$ns node]
$n20 set X_ 1502
$n20 set Y_ 4
$n20 set Z_ 0.0
$ns initial_node_pos $n20 20
set n21 [$ns node]
$n21 set X_ 953
$n21 set Y_ 164
$n21 set Z_ 0.0
$ns initial_node_pos $n21 20
set n22 [$ns node]
$n22 set X_ 636
$n22 set Y_ 107
$n22 set Z_ 0.0
$ns initial_node_pos $n22 20
set n23 [$ns node]
$n23 set X_ 980
$n23 set Y_ 164
$n23 set Z_ 0.0
$ns initial_node_pos $n23 20
set n24 [$ns node]
$n24 set X_ 1483
$n24 set Y_ 306
$n24 set Z_ 0.0
$ns initial_node_pos $n24 20
set n25 [$ns node]
$n25 set X_ 885
$n25 set Y_ -206
$n25 set Z_ 0.0
$ns initial_node_pos $n25 20

#===================================
#        Generate movement          
#===================================
$ns at 10 " $n7 setdest 560 356 12 " 
$ns at 30 " $n7 setdest 450 675 15 " 
$ns at 50 " $n7 setdest 250 800 8 " 
$ns at 10 " $n15 setdest 800 100 13 " 
$ns at 30 " $n15 setdest 500 250 18 " 
$ns at 45 " $n15 setdest 450 350 7 " 
$ns at 10 " $n22 setdest 700 200 9 " 
$ns at 30 " $n22 setdest 500 250 13 " 
$ns at 40 " $n22 setdest 750 300 17 " 
$ns at 45 " $n22 setdest 345 800 15 " 

#===================================
#        Agents Definition        
#===================================
#Setup a TCP connection
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set sink3 [new Agent/TCPSink]
$ns attach-agent $n25 $sink3
$ns connect $tcp0 $sink3
$tcp0 set packetSize_ 512

#Setup a TCP connection
set tcp4 [new Agent/TCP]
$ns attach-agent $n1 $tcp4
set sink6 [new Agent/TCPSink]
$ns attach-agent $n24 $sink6
$ns connect $tcp4 $sink6
$tcp4 set packetSize_ 512

#Setup a TCP connection
set tcp7 [new Agent/TCP]
$ns attach-agent $n4 $tcp7
set sink9 [new Agent/TCPSink]
$ns attach-agent $n14 $sink9
$ns connect $tcp7 $sink9
$tcp7 set packetSize_ 512

#Setup a TCP connection
set tcp8 [new Agent/TCP]
$ns attach-agent $n21 $tcp8
set sink10 [new Agent/TCPSink]
$ns attach-agent $n19 $sink10
$ns connect $tcp8 $sink10
$tcp8 set packetSize_ 512


#===================================
#        Applications Definition        
#===================================
# FTP Application 1
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns at 5.0 "$ftp0 start"
$ns at 45.0 "$ftp0 stop"

# FTP Application 2
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp4
$ns at 6.0 "$ftp1 start"
$ns at 45.0 "$ftp1 stop"

# FTP Application 3
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp7
$ns at 7.0 "$ftp2 start"
$ns at 45.0 "$ftp2 stop"

# FTP Application 4
set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcp8
$ns at 8.0 "$ftp3 start"
$ns at 45.0 "$ftp3 stop"


#===================================
#        Termination        
#===================================
#Define a 'finish' procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam AODV_26.nam &
    exit 0
}
for {set i 0} {$i < $val(nn) } { incr i } {
    $ns at $val(stop) "\$n$i reset"
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run
