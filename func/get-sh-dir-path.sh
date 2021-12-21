#!/usr/bin/env bash
# 返回 sh 脚本所在目录绝对路径

function get_sh_dir_path(){
  local sh_dir_path=$0
  if [[ "$sh_dir_path" =~ "/" ]] ; then
    sh_dir_path="${sh_dir_path%/*}"
    if [[ $(echo "$sh_dir_path" | cut -c1) != '/' ]] ; then
      sh_dir_path="$(pwd)/$sh_dir_path"
    fi
  else
    sh_dir_path="$(pwd)"
  fi
  echo $sh_dir_path
}