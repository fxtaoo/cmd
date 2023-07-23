#!/usr/bin/env bash
# linux x86_64 安装 docker-compose
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/fxtaoo/cmd/master/install/docker-compose.sh)"
# bash -c "$(curl -fsSL https://proxy.fxtaoo.dev/cmd/install/docker-compose.sh)"

set -eu

sudo mkdir -p /usr/local/lib/docker/cli-plugins/
sudo curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
