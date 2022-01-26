#!/bin/bash
# centos docker 安装
# 国内 腾讯源 七牛 Docker Hub 镜像
# bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/centos-docker.sh)"

function is_root() {
  if [[ 0 != "$UID" ]]; then # "$(id -nu)" != "root"
    echo "当前用户不是 root 用户"
    exit 1
  fi
}
is_root

if ping -c 2 google.com ; then
    # 执行官方安装脚本
    curl -fsSL https://get.docker.com -o get-docker.sh
    DRY_RUN=1 sh ./get-docker.sh
    rm ./get-docker.sh
else 
    # 命令行安装，配置国内源

    curl -o /etc/yum.repos.d/docker-ce.repo https://mirrors.cloud.tencent.com/docker-ce/linux/centos/docker-ce.repo

    yum makecache fast && yum install docker-ce docker-ce-cli containerd.io -y

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