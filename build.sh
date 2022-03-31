#!/usr/bin/env bash
# 生成 READ.me 文件
# 提交变更

go run ./readmeBuild/main.go

if [[ $(git status | wc -l) -gt 4 ]] ; then
    git config --global user.name  "GitHub Actions"
    git config --global user.name  "GitHub Actions"
    git config --global user.email  "i@fxtaoo.dev"
    git add .
    git commit -m "生成 READ.me 文件"
fi