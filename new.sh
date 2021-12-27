#!/usr/bin/env bash
# 创建符合 readme-build 格式的项目

run_dir_path=$(dirname $0)
source $run_dir_path/func/string-middle-underline.sh

# 输入类别
while true ; do
  read -rp "
  1.app 2.install
  3.sys 4.func 5.other
  
  适用系统编号：" sort
  case $sort in
   1 )
    sort="app"
    break
    ;;
   2 )
    sort="install"
    break
    ;;
   3 )
    sort="sys"
    break
    ;;
   4 )
    sort="func"
    break
    ;;
   5 )
    sort="other"
    break
    ;;
   *)
    echo "$sort 输入有误，重新输入！"
    ;;
  esac
done

# 输入名字
while true ; do
  read -rp "文件名：" file_name
  file_name="$(string_middle_underline $file_name)"
  if [[ ! -f $file_name ]] ; then
    break;
  fi
  echo -e "重新输入 $file_name 该文件以存在!\n"
done

read -rp "简介：" intro

content="#!/usr/bin/env bash
# $intro

function $file_name(){
}
"

# 创建文件
echo "$content"  > ./$sort/$file_name.sh

# vscode 存在则打开
if which code ; then
  code ./$sort/$file_name.sh
fi


