#!/usr/bin/env bash
# 文件夹路径添加到 PATH (递归)
# $1 为指定 cmd 绝对路径

function add_path(){
  local cmd_path=$1
  if [[ ! $PATH =~ $cmd_path ]] ; then
    PATH="$PATH:$cmd_path"
  fi
  for e in "$cmd_path"/* ; do
    if [[ -d $e  && ! $PATH =~ $e ]] ; then
      PATH="$PATH:$e"
      add_path $e
    else
      if [[ ! -x $e ]] ;  then
        chmod u+x $e
      fi
    fi
  done
}