#!/usr/bin/env bash
# 系统版本
# bash -c "$(curl -fsSL https://proxy.fxtaoo.dev/raw/fxtaoo/cmd/master/sys/get-sys-version.sh)"
# bash -c "$(wget -qO - https://proxy.fxtaoo.dev/raw/fxtaoo/cmd/master/sys/get-sys-version.sh)"

set -e

sys_version=$(grep 'VERSION_CODENAME' /etc/os-release | awk -F '=' '{print $2}')
echo $sys_version

