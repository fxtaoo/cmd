#!/usr/bin/env bash
# 出口 IP
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/fxtaoo/cmd/master/sys/get-local-ip.sh)"
# bash -c "$(curl -fsSL https://proxy.fxtaoo.dev/cmd/sys/get-local-ip.sh)"

function get_local_ip(){
  curl -4L api64.ipify.org
  echo
}
get_local_ip
