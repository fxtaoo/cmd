#!/bin/bash
# debian 安装 docker
# 国内 腾讯源 七牛 Docker Hub 镜像
# bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/debian-docker.sh)"
# bash -c "$(wget -O - https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/debian-docker.sh)"

function is_root() {
  if [[ 0 != "$UID" ]]; then # "$(id -nu)" != "root"
    echo "当前用户不是 root 用户"
    exit 1
  fi
}
is_root

apt-get apt-get remove docker docker-engine docker.io containerd runc

apt-get update

apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release


normal_url="download.docker.com"
docker_daemon="docker-daemon"

if ! ping 2 google.com ;then
  normal_url="mirrors.cloud.tencent.com/docker-ce"
  docker_daemon="docker-daemon-cn"
fi

mkdir -p /etc/apt/keyrings
curl -fsSL https://${normal_url}/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://${normal_url}/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

mkdir -p /etc/docker
curl -o /etc/docker/daemon.json https://raw.fxtaoo.dev/fxtaoo/cmd/master/conf/${docker_daemon}.json

systemctl enable docker
systemctl restart docker