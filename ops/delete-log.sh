#!/usr/bin/env bash
# 删除日志
# $1 日志路径
# $2 日志保留天数
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/fxtaoo/cmd/master/ops/delete-log.sh.sh)"
# bash -c "$(curl -fsSL https://proxy.fxtaoo.com/cmd/ops/delete-log.sh.sh)"

set -eux

log_path=$1
save_day=$2
backup_dir="${log_path}/backup/$(date -d "yesterday" +%Y/%m/%d)"

mkdir -p $backup_dir
mv ${log_path}/*.log ${backup_dir}

# 删除超过时间的日志
find "${log_path}/backup" -type f -mtime +${save_day} -name '*.log' -delete
find "${log_path}/backup" -depth -type d -empty -delete