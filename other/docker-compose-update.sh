#!/usr/bin/env bash
# docker-compose 容器镜像更新重建
# $1 指定配置文件（绝对路径），缺省使用当前工作目录 docker-compose.yml
# bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/other/docker-compose-update.sh)"
# bash -c "$(wget -O - https://raw.fxtaoo.dev/fxtaoo/cmd/master/other/docker-compose-update.sh)"

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

/usr/bin/docker compose -f $conf_path pull
/usr/bin/docker compose -f $conf_path down -v
/usr/bin/docker compose -f $conf_path up -d

