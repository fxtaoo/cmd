#!/bin/bash
# centos 安装 docker
# 国内 腾讯源 七牛 Docker Hub 镜像
# bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/centos-docker.sh)"
# bash -c "$(wget -O - https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/centos-docker.sh)"

function is_root() {
  if [[ 0 != "$UID" ]]; then # "$(id -nu)" != "root"
    echo "当前用户不是 root 用户"
    exit 1
  fi
}
is_root

yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

yum install -y yum-utils

docker_ce_repo="https://download.docker.com/linux/centos/docker-ce.repo"
docker_daemon="docker-daemon"

if ! ping -c 2 google.com ; then
    # 使用腾讯源
    docker_ce_repo="https://mirrors.cloud.tencent.com/docker-ce/linux/centos/docker-ce.repo"
    docker_daemon="docker-daemon-cn"
fi

yum-config-manager \
  --add-repo \
  ${docker_ce_repo}

yum makecache fast && yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

mkdir -p /etc/docker
curl -o /etc/docker/daemon.json https://raw.fxtaoo.dev/fxtaoo/cmd/master/conf/${docker_daemon}.json

systemctl enable docker
systemctl restart docker