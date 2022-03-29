#!/usr/bin/env bash
# 杀死指定字符串相关进程
# $1 指定字符串进程
# bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/app/kill-ps-grep-str.sh)"

oldifs=$IFS
IFS=$'\n'
for e in $(ps aux | grep $1);do
    if [[ $(echo $e | awk '{print $11}') == "$1" ]] ; then
        for e2 in $(echo $e | awk '{print $2}');do
            kill $e2
        done
    fi
done
IFS=$oldifs