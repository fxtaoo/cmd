#!/usr/bin/env bash
# 指定监控文件目录变更执行脚本
# $1 文件|目录 绝对路径
# $2 执行脚本 绝对路径
# bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/app/inotifywait.sh)"

# 需要安装 inotify-tools

/usr/bin/inotifywait -mrq -e modify,attrib,move,create,delete $1 |
    while read -r path action file; do
        bash $2
        sleep 1m
    done