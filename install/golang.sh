#!/usr/bin/env bash
# golang 指定版本重装（linux-amd64，科大源）
# $1 指定 golang 版本号，eg:1.17.6
# $1 缺省 1.17.6
# bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/golang.sh)"

# 手动指定版本
if [[ $1 ]] ; then
 golang_version=$1
fi

golang_file_path="/tmp/go${golang_version:=1.17.6}.linux-amd64.tar.gz"

wget http://mirrors.ustc.edu.cn/golang/go${golang_version}.linux-amd64.tar.gz -O $golang_file_path

if [[ -e $golang_file_path ]] ; then
  sudo rm -rf /usr/local/go && \
  sudo tar -C /usr/local \
  -xzf $golang_file_path
else
  echo "未更新！$golang_file_path 该文件不存在！"
  exit 1
fi

# 国内使用七牛 Go 模块代理
# https://github.com/goproxy/goproxy.cn/blob/master/README.zh-CN.md
if ! ping -c 2 google.com ; then
  go env -w GO111MODULE=on
  go env -w GOPROXY=https://goproxy.cn,direct
fi