#!/usr/bin/env bash
# golang 指定版本重装（linux-amd64，科大源）
# $1 指定 golang 版本号，eg:1.17.5
# $1 缺省 1.17.5

# 手动指定版本
if [[ $1 ]] ; then
 golang_version=$1
fi

golang_file_path="/tmp/go${golang_version:=1.17}.linux-amd64.tar.gz"

wget http://mirrors.ustc.edu.cn/golang/go${golang_version}.linux-amd64.tar.gz -O $golang_file_path

if [[ -e $golang_file_path ]] ; then
  sudo rm -rf /usr/local/go && \
  sudo tar -C /usr/local \
  -xzf $golang_file_path
else
  echo "未更新！$golang_file_path 该文件不存在！"
  exit 1
fi