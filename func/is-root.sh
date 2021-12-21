#!/usr/bin/env bash
# 判断并提示需要 root 用户执行

function is_root() {
  if [[ 0 != "$UID" ]]; then # "$(id -nu)" != "root"
    echo "当前用户不是 root 用户"
    exit 1
  fi
}
# is_root