#!/bin/bash
# 重置用户密码
# $1 用户未指定，默认执行脚本用户
# $2 用户未指定，生成 10 位随机密码

function create_passwd(){
  local num=$1
  local passwd
  if (( ${num:=10} < 4 )) ; then
    echo "密码位数至少为 4 位，数字 大写字符 标点符号"
    exit 1
  fi
  # 循环生成密码，直至生成符合要求密码
  while : ; do
    # tr -d 删除指定集 -c 反转
    passwd="$(strings /dev/urandom | tr -dc '[:print:]'  | head -c$num)"
    # 密码强度验证
    # 必须含有 数字 大小写字符 标点符号
    if [[ $(echo $passwd | sed 's/[[:digit:]]//') != "$passwd" && \
    $(echo $passwd | sed 's/[[:lower:]]//') != "$passwd" && \
    $(echo $passwd | sed 's/[[:upper:]]//') != "$passwd" && \
    $(echo $passwd | sed 's/[[:punct:]]//') != "$passwd" && \
    # 排除难终端分辨字符出现如 空格 等
    $(echo $passwd | sed "s/[ 0oO1Ilz29gb6\"'\`]//") == "$passwd" ]] ; then
      break
    fi
  done
  echo $passwd
}

function change_user_passwd(){
  local user_name
  local new_passwd
  user_name=$1
  new_passwd=$2
  if $user_name ; then
    user_name="$USER"
  fi

  if $new_passwd ; then
    new_passwd=$(create_passwd 10)
  fi
  echo -e "$new_passwd\n$new_passwd" | passwd $user_name
  echo "$user_name 密码修改为：$new_passwd"
}