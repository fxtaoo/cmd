#!/usr/bin/env bash
# 当前用户列表

function get_user_name_list(){
  grep -v 'nologin' /etc/passwd | cut -f 1 -d ':'
}