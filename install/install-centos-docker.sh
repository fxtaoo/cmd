#!/bin/bash
# centos docker 安装
# 腾讯源
# 七牛 Docker Hub 镜像

curl -o /etc/yum.repos.d/docker-ce.repo https://mirrors.cloud.tencent.com/docker-ce/linux/centos/docker-ce.repo


yum makecache fast
yum install docker-ce docker-ce-cli containerd.io -y

# 七牛 Docker Hub 镜像
mkdir /etc/docker
echo '{
    "registry-mirrors": [
        "https://reg-mirror.qiniu.com"
    ]
}' > /etc/docker/daemon.json 

systemctl enable docker
systemctl restart docker