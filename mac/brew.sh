#!/usr/bin/env bash
# 记录 macOS 中 brew 应用
# 环境变量 $BREW_LIST_PATH 指定 brew-list 路径，缺省在 brew.sh 同目录中
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/fxtaoo/cmd/master/ma c/brew.sh)"
# bash -c "$(curl -fsSL https://proxy.fxtaoo.dev/cmd/mac/brew.sh)"

set -ex

if [[ ${BREW_LIST_PATH} == "" ]];then
    BREW_LIST_PATH="$(dirname ${BASH_SOURCE[0]})/brew-list"
fi

p_2=$(echo "$*" | awk '{print $1}')

if eval brew "$*";then
    # 执行 brew 命令成功后修改
    p_3=$(echo "$*" | awk '{print $2}')
    tmpfile=$(mktemp)
    case $p_2 in
        install)
            echo "$p_3" >> $BREW_LIST_PATH
            cat $BREW_LIST_PATH > $tmpfile
        ;;
        uninstall)
            grep -vw $p_3 $BREW_LIST_PATH > $tmpfile
        ;;
        *)
            exit 0
    esac
    sort $tmpfile > $BREW_LIST_PATH
fi
