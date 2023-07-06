#!/usr/bin/env bash
# 记录 macOS 中 brew 应用
# 记录在 brew.sh 同目录 brew-list 中
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/fxtaoo/cmd/master/other/brew.sh)"
# bash -c "$(curl -fsSL https://proxy.fxtaoo.dev/cmd/other/brew.sh)"

set -eu

brew_list_path="$(dirname ${BASH_SOURCE[0]})/brew-list"

p_2=$(echo "$*" | awk '{print $1}')

if eval brew "$*";then
    # 执行 brew 命令成功后修改
    p_3=$(echo "$*" | awk '{print $2}')
    tmpfile=$(mktemp)
    case $p_2 in
        install)
            echo "$p_3" >> $brew_list_path
            cat $brew_list_path > $tmpfile
        ;;
        uninstall)
            grep -vw $p_3 $brew_list_path > $tmpfile
        ;;
        *)
            exit 0
    esac
    sort $tmpfile > $brew_list_path
fi
