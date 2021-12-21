#!/usr/bin/env bash
# 创建 docker-compose.yml
# $1 应用名
# 不存在截断

if [[ $# == 1 ]] ; then
  mkdir $1
  echo "version: '3'
  services:
    $1:
      image: $1
      container_name: $1
      restart: always
      ports:
        - \"\":\"\"
      network_mode: \"host\"
      volumes:
        - :ro
      depends_on:
        -" > $1/docker-compose.yml
  echo "# $1" > $1/README.md
  cd $1
else 
  echo "重新输入应用名!"
fi
