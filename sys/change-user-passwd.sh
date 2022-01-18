#!/bin/bash
# 重置用户密码
# $1 用户未指定，默认执行脚本用户
# $2 用户未指定，生成 10 位随机密码

# 导入生成密码函数
curl -o /tmp/create-passwd.sh https://raw.fxtaoo.dev/fxtaoo/cmd/master/app/create-passwd.sh
source "/tmp/create-passwd.sh"

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
  # echo -e "$new_passwd\n$new_passwd" | passwd $user_name
  echo "$user_name 密码修改为：$new_passwd"
}

change_user_passwd $1 $2