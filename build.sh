#!/usr/bin/env bash
# 生成 READ.me 文件
# 提交变更

go run ./readme-build/main.go

git config --global user.name  "GitHub Actions"
git config --global user.email  "i@fxtaoo.dev"
git add .
git commit -m "生成 READ.me 文件"