#!/usr/bin/env bash
# Dropbox 忽略 git clone 文件夹
# $1 git clone 路径
# https://help.dropbox.com/zh-cn/sync/ignored-files
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/fxtaoo/cmd/master/macos/git-dropbox-ignored-mac.sh)"
# bash -c "$(curl -fsSL https://proxy.fxtaoo.dev/cmd/macos/git-dropbox-ignored-mac.sh)"

set -eu

git_url=$1
dir_name=${git_url##*/}
dir_name=${dir_name%.*}

mkdir $dir_name
xattr -w com.dropbox.ignored 1 ./$dir_name
git clone $git_url




