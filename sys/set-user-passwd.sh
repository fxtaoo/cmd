#!/bin/bash
# 重置用户密码
# $1 缺省执行脚本用户
# $2 缺省生成 10 位随机密码
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/fxtaoo/cmd/master/sys/set-user-passwd.sh)"
# bash -c "$(curl -fsSL https://proxy.fxtaoo.com/cmd/sys/set-user-passwd.sh)"

function set_user_passwd(){
  local user_name
  local new_passwd
  user_name=$1
  new_passwd=$2
  if $user_name ; then
    user_name="$USER"
  fi

  if $new_passwd ; then
    new_passwd=$(bash -c "$(curl -fsSL https://proxy.fxtaoo.com/cmd/func/create-passwd.sh) $new_passwd")
  fi
  echo -e "$new_passwd\n$new_passwd" | passwd $user_name
  echo "$user_name 密码修改为：$new_passwd"
}
set_user_passwd $1 $2
