#!/usr/bin/env bash
# 创建符合 readme-build 格式的项目

function convert_middle_underline(){
  local middle=$1
  echo "$middle" | sed 's/-/_/g'
}

# 输入类别
while true ; do
  read -rp "
  1.func 2.sys
  3.install 4.other

  适用系统编号：" sort
  case $sort in
   1 )
    sort="func"
    break
    ;;
   2 )
    sort="sys"
    break
    ;;
   3 )
    sort="install"
    break
    ;;
   4 )
    sort="func"
    break
    ;;
   *)
    echo "$sort 输入有误，重新输入！"
    ;;
  esac
done

# 输入名字
while true ; do
  read -rp "  文件名：" file_name
  func_name="$(convert_middle_underline $file_name)"
  if [[ ! -f $file_name ]] ; then
    break;
  fi
  echo -e "重新输入 $file_name 该文件以存在!\n"
done

read -rp "  简介：" intro

content="#!/usr/bin/env bash
# $intro
# bash -c \"\$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/$sort/$file_name.sh)\"
# bash -c \"\$(wget -qO - https://raw.fxtaoo.dev/fxtaoo/cmd/master/$sort/$file_name.sh)\"

function $func_name(){

}
"

# 创建文件
echo "$content"  > ./$sort/$file_name.sh


