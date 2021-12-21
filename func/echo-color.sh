#!/usr/bin/env bash
# 输入颜色字体

# 正确绿色
function echo_ok(){
  echo -e "\033[32m$1\033[0m"
  sleep 2
}

# 错误红色
function echo_error(){
  echo -e "\033[31m$1\033[0m"
}

# 提示黄色
function echo_point(){
  echo -e "\n\033[33m$1\033[0m"
}

# 开始蓝色
function echo_start(){
  echo -e "\033[34m$1\033[0m"
  sleep 1
}