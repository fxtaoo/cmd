#!/usr/bin/env bash
# 域名 IP

function get_domain_ip(){
  if ! ping -c 1 $1 > /dev/null; then
    exit 2
  fi
  ping $1 -c 1 | sed '1{s/[^(]*(//;s/).*//;q}'
}
get_domain_ip $1