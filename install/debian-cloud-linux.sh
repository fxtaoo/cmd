#!/usr/bin/env bash
# debian 安装 cloud 内核
# bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/debian-cloud-linux.sh)"

source /etc/os-release

mirrors='https://deb.debian.org/debian/'

if ! ping -c 1 google.com ; then
  mirrors='https://mirrors.cloud.tencent.com/debia'
fi

echo "deb $mirrors ${VERSION_CODENAME}-backports" | sudo tee /etc/apt/sources.list.d/backports.list > /dev/null


sudo apt -t "${VERSION_CODENAME}-backports" update && apt -y -t "${VERSION_CODENAME}-backports" upgrade

sudo apt -t "${VERSION_CODENAME}-backports" install linux-image-cloud-amd64 linux-headers-cloud-amd64

# dpkg -l | grep linux-image

# apt-get purge