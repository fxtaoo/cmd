#!/usr/bin/env bash
# 提示需 root 执行

function is_root() {
  if [[ '0' != $(id -u) ]]; then # "$(id -nu)" != "root"
    echo "当前用户不是 root 用户"
    exit 1
  fi
}
is_root