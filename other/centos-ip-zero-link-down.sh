#!/usr/bin/env bash
# CentOS ip 0 连接数,关闭网卡、注释配置 ifcfg-eth
# ！仅测试过 CentOS 5、7
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/fxtaoo/cmd/master/other/centos-ip-zero-link-down.sh)"
# bash -c "$(curl -fsSL https://proxy.fxtaoo.dev/cmd/other/centos-ip-zero-link-down.sh)"

# set -e

# 正确绿色
echo_ok(){
  echo -e "\033[32m$1\033[0m"
  sleep 1
}

# 错误红色
echo_error(){
  echo -e "\033[31m$1\033[0m"
  sleep 1
}

# 提示黄色
echo_point(){
  echo -e "\n\033[33m$1\033[0m"
  sleep 1
}

is_yes(){
  echo -ne '是否同意（y/n）：'; read -r input
  if  ! [[ $input == "y" ]]; then
    echo "以取消跳过！"
    exit 1
  fi
}

(
    IFS=$'\n'
    # 时间
    dt=$(date +"%Y%m%d%H%M%S")

    # 输出 ip 链接接数
    # 排除内网 10. 等等
    ips=$(ip a | grep -vwE 'inet6|10\.*|172\.*|192\.*|127\.*' | grep inet | awk '{print $2}' | cut -f1 -d'/')
    result=""

    for ip in $ips;do
        eth=$(ip a | grep $ip | awk '{print $NF}')
        num=$(ss -natp | grep -c $ip)
        result="$result
        $num $eth $ip"
    done
    echo -e $result | sort

    # down 网卡、注释配置
    for e in $result;do
        (
            num=$(echo $e | awk '{print $1}')
            if [[ $num == "0" ]];then
                echo_point "$e 关闭并注释配置"
                is_yes
                eth=$(echo $e | awk '{print $2}')

                if ifdown $eth || ip link set $eth down;then
                    echo_ok "$eth 网卡关闭成功！"
                else
                    echo_error "$eth 网卡关闭失败！"
                fi

                cd /etc/sysconfig/network-scripts/
                cp ifcfg-${eth} bak-${dt}-ifcfg-${eth}
                if sed -i 's/^/#&/g' /etc/sysconfig/network-scripts/ifcfg-${eth};then
                    echo_ok "ifcfg-${eth} 配置注释成功！"
                else
                    echo_error "ifcfg-${eth} 配置注释失败！"
                fi
            fi
        )
    done

    echo_ok "执行结束"
)


