#!/usr/bin/env bash
# 监控文件目录变更执行脚本
# 需要安装 inotify-tools
# $1 文件或目录 绝对路径
# $2 执行脚本 绝对路径
# bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/other/inotifywait.sh)"
# bash -c "$(wget -qO - https://raw.fxtaoo.dev/fxtaoo/cmd/master/other/inotifywait.sh)"

/usr/bin/inotifywait -mrq -e modify,attrib,move,create,delete $1 |
    while read -r path action file; do
        bash $2
        sleep 1m
    done