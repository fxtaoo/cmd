#!/usr/bin/env bash
# 进程守护
# watchdog.sh 需要 & 后台运行
# $1 完整的可执行路径,绝对相对都可
# $2 (可选) 检查时间间隔，缺省 5s

run_cmd_path=$1
time=$2

while true ; do
 PID=$(pidof $run_cmd_path)
if [ -z "$PID" ];then
    bash -c "${run_cmd_path}"
fi
sleep ${time:=5}
done