#!/bin/bash
# centos 安装 docker
# 国内 腾讯源 七牛 Docker Hub 镜像
# bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/docker-centos.sh)"
# bash -c "$(wget -qO - https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/docker-centos.sh)"

set -e

(sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine || exit 0)

sudo yum install -y yum-utils

docker_ce_repo="https://download.docker.com/linux/centos/docker-ce.repo"
docker_daemon="docker-daemon"

if ! ping -c 1 google.com ; then
    # 使用腾讯源
    docker_ce_repo="https://mirrors.cloud.tencent.com/docker-ce/linux/centos/docker-ce.repo"
    docker_daemon="docker-daemon-cn"
fi

sudo yum-config-manager \
  --add-repo \
  ${docker_ce_repo}

sudo yum makecache fast && sudo yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo mkdir -p /etc/docker
sudo curl -o /etc/docker/daemon.json https://raw.fxtaoo.dev/fxtaoo/cmd/master/conf/${docker_daemon}.json

# 非root 用户加入 docker 用户组
if [[ $(id -u) != "0" ]]; then
    sudo usermod -aG docker $USER
    newgrp docker
fi

sudo systemctl enable --now docker


