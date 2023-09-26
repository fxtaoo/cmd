#!/usr/bin/env bash
# debian 安装 cloud 内核
# $1=backports 启用  backports
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/fxtaoo/cmd/master/install/debian-cloud-kernel.sh)"
# bash -c "$(curl -fsSL https://proxy.fxtaoo.com/cmd/install/debian-cloud-kernel.sh)"

set -eu

sys_version=$(grep 'VERSION_CODENAME' /etc/os-release | awk -F '=' '{print $2}')

if [[ $1 == 'backports' ]]; then
  sudo apt -t "${sys_version}-backports" update \
  && sudo apt -t "${sys_version}-backports" install -y linux-image-cloud-amd64 linux-headers-cloud-amd64
else
  sudo apt update \
  && sudo apt install -y linux-image-cloud-amd64 linux-headers-cloud-amd64
fi

# dpkg -l | grep linux-image
# apt purge
