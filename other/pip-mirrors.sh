#!/usr/bin/env bash
# pip 选择源
# bash -c "$(curl -fsSL https://proxy.fxtaoo.dev/raw/fxtaoo/cmd/master/install/pip_mirrors.sh)"
# bash -c "$(wget -qO - https://proxy.fxtaoo.dev/raw/fxtaoo/cmd/master/install/pip_mirrors.sh)"

function pip_mirrors(){
  if ping -c 1 google.com ; then
    pip3  install --upgrade pip
  else
    pip3 install -i https://mirrors.cloud.tencent.com/pypi/simple --upgrade pip
    pip config set global.index-url https://mirrors.cloud.tencent.com/pypi/simple
  fi
}
pip_mirrors