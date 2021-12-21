#!/bin/bash
# debian docker 安装

source '/etc/os-release'

mirrors_address="download.docker.com"

if ! ping -c 1 google.com ; then
# 国内源
  mirrors_address="mirrors.cloud.tencent.com/docker-ce"
  echo '
{
  "registry-mirrors": [
    "https://hub-mirror.c.163.com",
    "https://mirror.baidubce.com"
  ]
}' | sudo tee /etc/docker/daemon.json > /dev/null
fi

sudo apt update

sudo apt install \
    ca-certificates \
    curl \
    gnupg \

curl -fsSL https://$mirrors_address/linux/debian/gpg  | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  ${VERSION_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update \
&& sudo apt install docker-ce docker-ce-cli containerd.io -y \
&& sudo systemctl enable docker \
&& sudo usermod -aG docker $USER 