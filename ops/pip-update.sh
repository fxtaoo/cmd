#!/usr/bin/env bash
# pip 更新
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/fxtaoo/cmd/master/ops/pip-update.sh)"
# bash -c "$(curl -fsSL https://proxy.fxtaoo.dev/cmd/ops/pip-update.sh)"

if ping -c 1 google.com ; then
  pip  install --upgrade pip
else
  pip install -i https://mirrors.cloud.tencent.com/pypi/simple --upgrade pip
  pip config set global.index-url https://mirrors.cloud.tencent.com/pypi/simple
fi

