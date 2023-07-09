#!/usr/bin/env bash
# 删除镜像，设置保留几个版本
# $1 为保留版本数量（按 CREATED 时间由近到远依次），其余删除
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/fxtaoo/cmd/master/ops/docker-image-clean.sh)"
# bash -c "$(curl -fsSL https://proxy.fxtaoo.dev/cmd/ops/docker-image-clean.sh)"

set -eu

# 保留最近版本数
keep_num=$1
if (( keep_num < 1 ));then
    echo "\$1 必须 >= 1！"
fi

images=$(docker images | awk '{print $1}' | sort | uniq -d)

for e in $images; do
    e_num=$(docker images | grep -c $e)
    del_num=$(( e_num - keep_num ))
    if (( del_num > 1 )); then
        del_id=$(docker images | grep $e | tail -n $del_num | awk '{print $3}' | xargs)
        docker rmi $del_id
    fi
done



