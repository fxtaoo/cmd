#!/usr/bin/env bash
# debian 安装 cloud 内核
# bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/debian-cloud-linux.sh)"
# bash -c "$(wget -O - https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/debian-cloud-linux.sh)"

source /etc/os-release

mirrors='https://deb.debian.org/debian/'

if ! ping -c 1 google.com ; then
  mirrors='https://mirrors.cloud.tencent.com/debia'
fi

grep "backports" /etc/apt/sources.list || echo "deb $mirrors ${VERSION_CODENAME}-backports main" >> /etc/apt/sources.list.d/backports.list

apt -t "${VERSION_CODENAME}-backports" update && apt -y -t "${VERSION_CODENAME}-backports" upgrade

apt -t "${VERSION_CODENAME}-backports" install linux-image-cloud-amd64 linux-headers-cloud-amd64

# dpkg -l | grep linux-image
# apt-get purge