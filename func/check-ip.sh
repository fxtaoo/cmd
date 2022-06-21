#!/usr/bin/env bash
# 检查 IP 格式

function check_ip() {
    IP=$1
    if [[ $IP =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        FIELD1=$(echo $IP|cut -d. -f1)
        FIELD2=$(echo $IP|cut -d. -f2)
        FIELD3=$(echo $IP|cut -d. -f3)
        FIELD4=$(echo $IP|cut -d. -f4)
        if (( FIELD1 <= 255 && FIELD2 <= 255 && FIELD3 <= 255 && FIELD4 <= 255 )); then
            return 0
        else
            return 1
        fi
    else
        return 2
    fi
}
check_ip $1