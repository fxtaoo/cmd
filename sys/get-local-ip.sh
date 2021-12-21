#!/usr/bin/env bash
# 返回出口 IP

function get_local_ip(){
  curl -4L api64.ipify.org
}