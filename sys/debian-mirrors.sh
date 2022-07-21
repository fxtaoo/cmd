#!/usr/bin/env bash
# debian apt 腾讯源
# bash -c "$(curl -fsSL https://proxy.fxtaoo.dev/raw/fxtaoo/cmd/master/sys/debian-mirrors.sh)"
# bash -c "$(wget -qO - https://proxy.fxtaoo.dev/raw/fxtaoo/cmd/master/sys/debian-mirrors.sh)"

set -e

sudo apt install -y lsb_release

cp /etc/apt/sources.list /etc/apt/sources.list.b
sudo tee /etc/apt/sources.list <<< "deb https://mirrors.cloud.tencent.com/debian/ $(lsb_release -cs) main contrib non-free
deb https://mirrors.cloud.tencent.com/debian/ $(lsb_release -cs)-updates main contrib non-free
deb https://mirrors.cloud.tencent.com/debian/ $(lsb_release -cs)-backports main contrib non-free
deb https://mirrors.cloud.tencent.com/debian-security $(lsb_release -cs)-security main contrib non-free"

sudo apt update