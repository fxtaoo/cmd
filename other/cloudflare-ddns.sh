#!/usr/bin/env bash
# Cloudflare DDNS
# 3 个为必须参数：
# $1 域名，例如：fxtaoo.dev。
# $2 二级域名，例如 home.fxtaoo.dev。
# $3 cf authorization，参考下文 创建 cf authorization。
# 1 个为可选参数：
# $4 ttl 时间，单位分钟，同时为脚本定期执行时间，缺省为 3。
# 日志默认位置，脚本文件同目录下 cloudflare-ddns.log 文件
# bash -c "$(curl -fsSL https://proxy.fxtaoo.dev/raw/fxtaoo/cmd/master/other/cloudflare-ddns.sh)"
# bash -c "$(wget -qO - https://proxy.fxtaoo.dev/raw/fxtaoo/cmd/master/other/cloudflare-ddns.sh)"

set -e

cf_domain_nam=$1
cf_ddns_domain_name=$2
cf_authorization=$3
ttl=$4

ttl=${ttl:=3}
ttl=$(( ttl*60 ))
log_path="$(dirname $0)/cloudflare-ddns.log"

# 验证
if ! jq --version &> /dev/null;then
     echo "jq 命令未找到，脚本退出。" >> $log_path
     exit 1
fi

if [[ $cf_domain_nam == "" || $cf_ddns_domain_name == "" || $cf_authorization == "" ]];then
     echo "$1 $2 $3 为必须参数，有未配置，退出。" >> $log_path
fi

while true;do
     # 检查出口 ip 与解析是否一致
     export_ip=$(curl -s https://api.ipify.org)
     cf_ddns_domain_ip=$(ping -c 1 ${cf_ddns_domain_name} | head -n 1 | awk '{print $3}' | sed 's/[():]//g')
     if [[ "$export_ip" != "" && "$export_ip" != "$cf_ddns_domain_ip" ]];then
          # 验证 cf_authorization
          success=$(curl -sX GET "https://api.cloudflare.com/client/v4/user/tokens/verify" \
          -H "Authorization: Bearer ${cf_authorization}" \
          -H "Content-Type:application/json" | jq '.success')

          if [[ $success != "true" ]];then
               echo "Authorization 有误，脚本退出。" >> $log_path
               exit 1
          fi

          zone_identifier=$(curl -sX GET https://api.cloudflare.com/client/v4/zones \
               -H "Authorization: Bearer ${cf_authorization}" \
               -H "Content-Type:application/json" | jq '.result' | jq "map(select(.name==\"$cf_domain_nam\"))" |   jq '.[0].id' | tr -d '"')

          identifier=$(curl -sX GET https://api.cloudflare.com/client/v4/zones/${zone_identifier}/dns_records \
               -H "Authorization: Bearer ${cf_authorization}" \
               -H "Content-Type:application/json" | jq '.result' | jq "map(select(.name==\"$cf_ddns_domain_name\"))" | jq '.[0].id' | tr -d '"')

          result=$(curl -sX PUT https://api.cloudflare.com/client/v4/zones/${zone_identifier}/dns_records/${identifier} \
               -H "Authorization: Bearer ${cf_authorization}" \
               -H "Content-Type:application/json" \
               --data "{
               \"type\": \"A\",
               \"name\": \"${cf_ddns_domain_name}\",
               \"content\": \"${export_ip}\",
               \"proxied\": false,
               \"ttl\": ${ttl}
          }")

          log="$(date '+%Y-%m-%d %H:%M:%S') $(echo $result | jq '.result.name,.result.content,.success' | xargs)"
          echo $log >> $log_path

          success=$(echo $log | awk '{print $5}')
          if [[ $success != "true" ]];then
               echo "错误，脚本退出。" >> $log_path
               exit 1
          fi

          # 更新 dns 解析后，至少暂停 15 分钟等待解析生效
          if (( ttl > 15*60 ));then
               sleep $(( ttl-15*60 ))
          else
               sleep $(( 15*60-ttl ))
          fi
     fi

     sleep $ttl
done
