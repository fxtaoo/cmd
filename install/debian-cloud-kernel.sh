#!/usr/bin/env bash
# debian 安装 cloud 内核
# bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/debian-cloud-kernel.sh)"
# bash -c "$(wget -qO - https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/debian-cloud-kernel.sh)"

set -e

sudo apt update \
&& sudo apt install -y linux-image-cloud-amd64 linux-headers-cloud-amd64

# dpkg -l | grep linux-image
# apt purge