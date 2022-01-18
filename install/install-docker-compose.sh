#!/usr/bin/env bash
# centos 安装 docker-compose
# pip 配置为腾讯源

function install_docker_compose(){
  yum install -y python3-pip
  pip3 install -i https://mirrors.cloud.tencent.com/pypi/simple --upgrade pip
  pip config set global.index-url https://mirrors.cloud.tencent.com/pypi/simple
  pip install docker-compose
}

install_docker_compose

