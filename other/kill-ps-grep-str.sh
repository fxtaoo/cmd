#!/usr/bin/env bash
# 杀死指定字符串相关进程
# $1 指定字符串进程
# bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/other/kill-ps-grep-str.sh)"
# bash -c "$(wget -O - https://raw.fxtaoo.dev/fxtaoo/cmd/master/other/kill-ps-grep-str.sh)"

# grep_str=$1

# if [[ $grep_str == '' ]] ;then
#     read -rp "输入字符串将杀死相关进程：" str
# fi

# oldifs=$IFS
# IFS=$'\n'
# for e in $(ps aux | grep $grep_str);do
#     if [[ $(echo $e | awk '{print $11}') == "$grep_str" ]] ; then
#         for e2 in $(echo $e | awk '{print $2}');do
#             kill $e2
#         done
#     fi
# done
# IFS=$oldifs

for e in $(pidof $1) ; do
    kill $e
done