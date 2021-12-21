#!/bin/bash

## 函数内调用自身 ##
function daiyong(){
  echo "Hello"
  daiyong
}

# daiyong
# 无限输出 Hello
# 可以调用

## 目录链接是不是目录？ ##
function link_is_dir(){
  if [[ -h "$HOME/.ssh" ]] ; then
    echo "是软链接"
  fi

  if [[ -d "$HOME/.ssh" ]] ; then
    echo "是目录"
  fi
}
# link_is_dir
## 目录链接也是目录 ##

## grep 相关 ##
# function f_grep(){
  # ls / | grep -i -e mnt -e var
  # 多匹配
# }
# f_grep

## . 点隐藏目录会不会被 for in 读取？ ##
function hide_dir(){
  for e in "$HOME"/* ; do
    echo "$e"
  done
  
  for e in "$HOME"/.* ; do
    echo "$e"
  done
}
# hide_dir

## 字符缺省 ##
function zfqs(){
  v=$(which $1)
  echo $v
  echo ${v:=$(which bash)}
  # echo ${$(which $1):=$(which bash)}
  # test.sh: line 50: ${$(which $1):=$(which bash)}: bad substitution

}
# zfqs $1
# {} 配置缺省值，第一个参数必须以变量的形式

## su 切换到 root 用户执行本脚本 ##
function su_root(){
  if [[ $USER != 'root' ]] ; then 
    echo '切换到 root 运行'
    # su root -c 'pwd'
    # /home/fang/code/shell/psh/func
    # su - root -c 'pwd'
    # /root
    # (su - root "")
    # echo '1' >> ~/1
  fi
}

# su_root
## su - 初始化自身环境变量 ##

## 函数 exit 退出整个脚本？##
function f_exit(){
  echo 1
  exit 0
}

# f_exit
# echo 2

# (f_exit)
# echo 2
## 函数调用，没有加括号在子进程中
## 退出直接退出脚本

## 切换用户，执行命令？ ##

# function echo_user(){
#   echo $USER
# }

# su - root -c echo_user