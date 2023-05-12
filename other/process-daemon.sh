#!/usr/bin/env bash
# 进程守护
# 守护进程的执行文件（绝对路径）与参数写入脚本文件同目录下 process-daemon-list 文本
# 换行分隔多个进程
# $1 为检查间隔时间，单位秒，缺省为 3。
# bash -c "$(curl -fsSL https://proxy.fxtaoo.dev/raw/fxtaoo/cmd/master/other/process-daemon.sh)"
# bash -c "$(wget -qO - https://proxy.fxtaoo.dev/raw/fxtaoo/cmd/master/other/process-daemon.sh)"

path=$(dirname $0)
sleep_time=$1

while true;do
    datetime=$(date +"%Y-%m-%d %H:%M")
    while IFS=$'\n';read -r process;do
        process_file=$(echo $process | awk '{print $1}')
        num=$(ps aux | grep -v "grep" | grep -wc "$process_file")
        if [[ $process_file != "" ]] && (( num==0 ));then
            (
                cd "$(dirname $process_file)"
                eval nohup $process &
                echo "$datetime 启动 ${process_file}" >> ${path}/process-daemon.log
            )
        fi
    done <${path}/process-daemon-list
    sleep ${sleep_time:=3}
done
