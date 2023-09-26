#!/usr/bin/env bash
# 含有 .git 文件夹执行 git pull
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/fxtaoo/cmd/master/macos/dir-git-pull.sh)"
# bash -c "$(curl -fsSL https://proxy.fxtaoo.com/cmd/macos/dir-git-pull.sh)"

set -eu

for e in "$@";do
    echo $e
    for e2 in $(find $e -type d -name '.git' -print0 | xargs -0I {}  dirname {});do
        cd $e2 && git pull
    done
done




