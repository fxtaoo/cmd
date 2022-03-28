#!/usr/bin/env bash
# pip 更改源
# bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/pip-change-mirrors)"

function pip_change_mirrors(){
  if ping -c 2 google.com ; then
    pip3  install --upgrade pip
  else
    pip3 install -i https://mirrors.cloud.tencent.com/pypi/simple --upgrade pip
    pip config set global.index-url https://mirrors.cloud.tencent.com/pypi/simple  
  fi
}

pip_change_mirrors