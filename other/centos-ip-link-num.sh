#!/usr/bin/env bash
# centos ip 连接数
# ！仅测试过 CentOS 7

set -e

(
    # 排除内网 10. 等等
    ips=$(ip a | grep -v -E '10\.|inet6|127\.|172\.'  | grep inet | awk '{print $2}' | cut -f1 -d'/')
    result=""

    for ip in $ips;do
        eth=$(ip a | grep $ip | awk '{print $8}')
        num=$(ss -natp | grep -c $ip)
        result+="$num $eth $ip\n"
    done
    echo -e $result | sort
)

