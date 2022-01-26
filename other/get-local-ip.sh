#!/usr/bin/env bash
# 返回出口 IP
# bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/sys/get-local-ip.sh)"

function get_local_ip(){
  curl -4L api64.ipify.org
}