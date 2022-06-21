#!/usr/bin/env bash
# 日志输出
# $1 为日志路径
# 日志格式，OK 开头输出绿色，NO 开头输出红色

function echo_point(){
  echo -e "\n\033[33m$1\033[0m"
}

function echo_log(){
  echo_point "$0 运行结果："
    while IFS=$'\n' read -r line ; do
    if [[ ${line:0:2} == "OK" ]] ; then
      echo -e "\033[32m$line\033[0m"
    else
      echo -e "\033[31m$line\033[0m"
    fi
  done < $1
}
echo_log $1