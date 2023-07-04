#!/usr/bin/env bash
# linux 安装 watchexec gun 版本
# https://github.com/watchexec/watchexec/tree/main
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/fxtaoo/cmd/master/install/watchexec.sh)"
# bash -c "$(curl -fsSL https://proxy.fxtaoo.dev/cmd/install/watchexec.sh)"

set -e

version=$(curl --silent "https://api.github.com/repos/watchexec/watchexec/releases/latest" | jq -r .tag_name | sed 's/^.//')
curl -SL https://github.com/watchexec/watchexec/releases/download/v${version}/watchexec-${version}-x86_64-unknown-linux-gnu.tar.xz -o /tmp/watchexec-${version}-x86_64-unknown-linux-gnu.tar.xz
tar -xf /tmp/watchexec-${version}-x86_64-unknown-linux-gnu.tar.xz -O watchexec-${version}-x86_64-unknown-linux-gnu/watchexec | sudo tee /usr/local/bin/watchexec > /dev/null
sudo chmod +x /usr/local/bin/watchexec
