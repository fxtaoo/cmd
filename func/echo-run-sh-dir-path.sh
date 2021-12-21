#!/usr/bin/env bash
# 输出执行脚本所在目录路径

function run_sh_file_dir_name(){
  dir_path=$(dirname $0)
  echo $dir_path
}

# run_sh_file_dir

# cd "$(run_sh_file_dir)"
# 函数会在子进程中执行，目录切换要在函数外进行
# run_sh_file_dir