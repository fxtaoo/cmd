#!/usr/bin/env bash
# 删除所有未运行容器与卷

docker_ps_all=$(docker ps -a | cut -d ' ' -f1 | sed 's/CONTAINER//') # 换行存储到字符串变成了空格
docker_ps_quiet=$(docker ps --quiet)

# 剔除在运行
for e in $docker_ps_quiet ; do
  docker_ps_all=$(echo $docker_ps_all | sed "s/$e//")
done

docker rm $docker_ps_all
docker volume prune

# docker rm -v "$(docker ps -aq)"