#!/usr/bin/env bash
# debian apt 源
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/fxtaoo/cmd/master/sys/debian-mirrors.sh)"
# bash -c "$(curl -fsSL https://proxy.fxtaoo.dev/cmd/sys/debian-mirrors.sh)"

set -e

sys_version=$(grep 'VERSION_CODENAME' /etc/os-release | awk -F '=' '{print $2}')

mirrors='deb.debian.org'
if ! ping -c 1 google.com >/dev/null 2>&1; then
  mirrors='mirrors.cloud.tencent.com'
fi

sudo cp /etc/apt/sources.list /etc/apt/sources.list.b
sudo tee /etc/apt/sources.list <<< "deb https://${mirrors}/debian/ ${sys_version} main contrib non-free
deb https://${mirrors}/debian/ ${sys_version}-updates main contrib non-free
deb https://${mirrors}/debian/ ${sys_version}-backports main contrib non-free
deb https://${mirrors}/debian-security ${sys_version}-security main contrib non-free"

sudo apt update
