#!/bin/bash
# debian docker 安装
# 国内 腾讯源 七牛 Docker Hub 镜像

function is_root() {
  if [[ 0 != "$UID" ]]; then # "$(id -nu)" != "root"
    echo "当前用户不是 root 用户"
    exit 1
  fi
}

is_root

if ping -c 1 google.com ; then
    echo -e "执行官方安装脚本：\n"
    curl -fsSL https://get.docker.com -o get-docker.sh
    DRY_RUN=1 sh ./get-docker.sh
    rm ./get-docker.sh
else 
    echo -e "命令行安装，配置国内源：\n"

    apt update && apt install \
      apt-get install \
      ca-certificates \
      curl \
      gnupg \
      lsb-release

    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://mirrors.cloud.tencent.com/docker-ce/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

    curl -fsSL http://mirrors.cloud.tencent.com/docker-ce/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    # 七牛 Docker Hub 镜像
    mkdir -p /etc/docker
    echo '{
        "registry-mirrors": [
            "https://reg-mirror.qiniu.com"
        ]
    }' > /etc/docker/daemon.json 
fi

systemctl enable docker
systemctl restart docker