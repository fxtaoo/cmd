#!/usr/bin/env bash
# debian 安装 docker
# 国内 腾讯源 七牛 Docker Hub 镜像
# bash -c "$(curl -fsSL https://proxy.fxtaoo.dev/raw/fxtaoo/cmd/master/install/docker-debian.sh)"
# bash -c "$(wget -qO - https://proxy.fxtaoo.dev/raw/fxtaoo/cmd/master/install/docker-debian.sh)"

set -e

(sudo apt remove docker docker-engine docker.io containerd runc || exit 0)

sudo apt update
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg

mirrors="download.docker.com"
docker_daemon="docker-daemon"
if ! ping -c 1 google.com >/dev/null 2>&1 ;then
  mirrors="mirrors.cloud.tencent.com/docker-ce"
  docker_daemon="docker-daemon-cn"
fi

sys_version=$(grep 'VERSION_CODENAME' /etc/os-release | awk -F '=' '{print $2}')

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://${mirrors}/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://${mirrors}/linux/debian \
  ${sys_version} stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# docker 配置
mkdir -p /etc/docker
sudo curl -o /etc/docker/daemon.json https://proxy.fxtaoo.dev/raw/fxtaoo/cmd/master/conf/${docker_daemon}.json

# 非root 用户加入 docker 用户组
if [[ $(id -u) != "0" ]]; then
    sudo usermod -aG docker $USER
    newgrp docker
fi

sudo systemctl enable --now docker