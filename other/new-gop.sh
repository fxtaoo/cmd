#!/usr/bin/env bash
# 创建序列 go 项目
# 序列：当前目录 n，序列号为 n+1
# $1 为文件名名
# $2 注释说明

num=1

for file in ./*;do
  if [[ -d $file ]] ; then
    ((num++))
  fi
done

dir_name="$num-$1"
mkdir ./$dir_name \
&& echo -e "// $2\n" > ./$dir_name/main.go

# vscode 存在则打开
if which code ; then
  code ./$dir_name/main.go
fi

