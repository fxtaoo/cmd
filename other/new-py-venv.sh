#!/bin/bash
# 工作目录开启 python 虚拟环境
# 默认以安装 python3-venv

if [[ ! -e pyvenv.cfg ]] ; then
  python3 -m venv .
fi

# 若为 git 仓库，配置 .gitignore
py_venv_gitignore='# python vnev
man
**/bin
**/include
**/lib
**/lib64
**/share
**/pyvenv.cfg'

OLD_IFS=$IFS
IFS='
'
if [[ -d .git ]] ; then
  # 删除可能以存在
  cmd="grep -v"
  for e in $py_venv_gitignore ; do
    cmd="$cmd -e '^$e'"
  done
  eval $cmd .gitignore > .gitignore.tmp && mv .gitignore.tmp .gitignore
  echo "$py_venv_gitignore" >> .gitignore
fi

echo '' >> requirements.txt

IFS=$OLD_IFS