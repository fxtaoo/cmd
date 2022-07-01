#!/usr/bin/env bash
# go 指定版本重装
# $1 指定 go 版本号，eg:1.18.3,缺省 1.18.3
# $2 指定架构，缺省 linux-amd64
# bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/golang.sh)"
# bash -c "$(wget -qO - https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/golang.sh)"

go_version=$1
cpu_type=$2

go_file_name="go${go_version:=1.18.3}.${cpu_type:=linux-amd64}.tar.gz"
go_file_path="/tmp/{$go_file_name}"

wget http://mirrors.ustc.edu.cn/golang/${go_file_name} -O $go_file_path

if [[ -e $go_file_path ]] ; then
  sudo rm -rf /usr/local/go && \
  sudo tar -C /usr/local -xzf $go_file_path
else
  echo "未更新！$go_file_path 该文件不存在！"
  exit 1
fi

# 国内使用七牛 Go 模块代理
# https://github.com/goproxy/goproxy.cn/blob/master/README.zh-CN.md
if ! ping -c 2 google.com ; then
  (
    PATH="$PATH:/usr/local/go/bin"
    go env -w GO111MODULE=on
    go env -w GOPROXY=https://goproxy.cn,direct
  )
fi