#!/usr/bin/env bash
# 删除所有未运行容器与卷
# bash -c "$(curl -fsSL https://proxy.fxtaoo.dev/raw/fxtaoo/cmd/master/other/docker-rm-no-run.sh)"
# bash -c "$(wget -qO - https://proxy.fxtaoo.dev/raw/fxtaoo/cmd/master/other/docker-rm-no-run.sh)"

# docker_ps_all=$(docker ps -a | cut -d ' ' -f1 | sed 's/CONTAINER//') # 换行存储到字符串变成了空格
# docker_ps_quiet=$(docker ps --quiet)

# # 剔除在运行
# for e in $docker_ps_quiet ; do
#   docker_ps_all=$(echo $docker_ps_all | sed "s/$e//")
# done

# docker rm $docker_ps_all
# docker volume prune


docker ps -a | grep 'Exited'

echo -ne "\033[31m任意键执行删除(docker rm -vf)，退出输入 n|no：\033[0m"
read -r yn
if [[ $yn == "n" || $yn == "no" ]] ; then
  exit 0
fi
docker rm -v "$(docker ps -a | grep 'Exited' | awk '{print $1}' | xargs)" > /dev/null