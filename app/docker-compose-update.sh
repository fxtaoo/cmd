#!/usr/bin/env bash
# docker-compose 容器镜像更新并重建服务
# $1 指定配置文件（绝对路径）
# $1 缺省使用当前工作目录 docker-compose.yml


# 确定配置文件位置
conf_path="$(pwd)/docker-compose.yml"
if [[ $1 ]]  ; then
  conf_path=$1
fi

if [[ ! -e $conf_path ]] ; then
  echo "退出！$conf_path 不存在！"
  exit 1
fi

if  ! which docker-compose  ; then
  echo "退出！docker-compose 不存在！"
fi

docker-compose -f $conf_path pull
docker-compose -f $conf_path down -v
docker-compose -f $conf_path up -d

