#!/usr/bin/env bash
# 创建序列 go 项目
# 序列：当前目录 n，序列号为 n+1
# $1 目录名
# $2 注释

if [ $# -lt 2 ] ; then
    echo "请输入 \$1 目录名和 \$2 注释"
    exit 1
fi

dir_num=1

for dir in ./*;do
  if [[ -d $dir ]] ; then
    ((dir_num++))
  fi
done

dir_name="$dir_num-$1"


(mkdir ./$dir_name && \
cd ./$dir_name && \
go mod init $dir_name && \
echo -e "// $2\n\npackage main" > ./main.go && \
echo -e "# $2" > ./README.md)

if [ $? -eq 0 ] ; then
    echo -e "[$dir_num-$2](./$dir_name/README.md)" >> README.md
fi