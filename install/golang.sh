#!/usr/bin/env bash
# golang 安装
# $1 指定 go 版本号，eg:1.18.4,缺省 1.18.4
# $2 指定架构，缺省 linux-amd64
# bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/golang.sh)"
# bash -c "$(wget -qO - https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/golang.sh)"

set -e

go_version=$1
cpu_type=$2

go_file_name="go${go_version:=1.18.4}.${cpu_type:=linux-amd64}.tar.gz"
go_file_path="/tmp/${go_file_name}"

wget https://mirrors.aliyun.com/golang/${go_file_name} -O $go_file_path

if [[ -e $go_file_path ]] ; then
  sudo rm -rf /usr/local/go && \
  sudo tar -C /usr/local -xzf $go_file_path
  rm -f $go_file_path
fi

# 七牛代理
if ! ping -c 1 google.com ; then
  (
    PATH="$PATH:/usr/local/go/bin"
    go env -w GO111MODULE=on
    go env -w GOPROXY=https://goproxy.cn,direct
  )
fi