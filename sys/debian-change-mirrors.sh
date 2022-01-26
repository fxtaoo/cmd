#!/usr/bin/env bash
# 更改为腾讯源
# bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/sys/debian-change-mirrors.sh)"

function change_debian_mirrors(){
  source /etc/os-release
  cp /etc/apt/sources.lis /etc/apt/sources.lis.b
  echo "deb https://mirrors.cloud.tencent.com/debian/ ${VERSION_CODENAME} main contrib non-free
deb https://mirrors.cloud.tencent.com/debian/ ${VERSION_CODENAME}-updates main contrib non-free
deb https://mirrors.cloud.tencent.com/debian/ ${VERSION_CODENAME}-backports main contrib non-free" > /etc/apt/sources.lis
}

change_debian_mirrors

