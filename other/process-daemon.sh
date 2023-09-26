#!/usr/bin/env bash
# 进程守护
# 守护进程的执行文件（绝对路径）与参数写入脚本文件同目录下 process-daemon-list 文本
# 换行分隔多个进程
# $1 为检查间隔时间，单位秒，缺省为 3。
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/fxtaoo/cmd/master/other/process-daemon.sh)"
# bash -c "$(curl -fsSL https://proxy.fxtaoo.com/cmd/other/process-daemon.sh)"

path=$(dirname $0)
sleep_time=$1

while true;do
    datetime=$(date +"%Y-%m-%d %H:%M")
    while IFS=$'\n';read -r process;do
        process_path=$(echo $process | awk '{print $1}')
        process_name=$(basename $process_path)
        num=$(pidof $process_name)
        if (( num==0 ));then
            num=$(ps axu | grep -v grep | grep -c "./$process_name")
        fi
        if [[ $process != "" ]] && (( num==0 ));then
            (
                cd "$(dirname $process_path)"
                # 所有参数
                process_p=$(echo $process | awk '{ for (i = 2; i <= NF; i++) print $i }')
                chmod u+x $process_name
                eval nohup ./$process_name $process_p &
                echo "$datetime 启动 ${process}" >> ${path}/process-daemon.log
            )
        fi
    done <${path}/process-daemon-list
    sleep ${sleep_time:=3}
done
