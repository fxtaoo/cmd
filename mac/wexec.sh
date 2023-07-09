#!/usr/bin/env bash
# 文件目录变更执行脚本
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/fxtaoo/cmd/master/mac/wexec.sh)"
# bash -c "$(curl -fsSL https://proxy.fxtaoo.dev/cmd/mac/wexec.sh)"

set -eu

cd "$(pwd)"

if [[ "$*" == "" ]];then
    echo "命令为空"
    exit 1
fi

watchexec -p --delay-run 2 "$*"
