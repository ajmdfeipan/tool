#!/bin/bash
#a simple example for "tc"
#set the param

DELAY=20
SPEED=$2
FLOW=0

#出口网卡
NETWORK_CARD=$(ip ro get 115.29.128.27 | grep eth | awk '{print $5}')

#NODE_IP 节点服务器ip
NODE_IP1=115.29.128.27
#NODE_IP2=192.168.8.250
start () {
    /sbin/tc qdisc add dev ${NETWORK_CARD} root handle 1: htb default 25
    /sbin/tc class add dev ${NETWORK_CARD} parent 1: classid 1:1 htb rate ${SPEED}kbps
    /sbin/tc qdisc add dev ${NETWORK_CARD} parent 1:1 netem delay ${DELAY}ms ${FLOW}ms
    /sbin/tc filter add dev ${NETWORK_CARD} parent 1: protocol ip prio 1 u32 match ip dst ${NODE_IP1}/32 flowid 1:1
 #   /sbin/tc filter add dev ${NETWORK_CARD} parent 1: protocol ip prio 1 u32 match ip dst ${NODE_IP2}/32 flowid 1:1
}

stop () {
    /sbin/tc qdisc dele dev ${NETWORK_CARD} root
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    *)
        echo "Usage: `basename $0` {start|stop} speed(kb/s)"
esac