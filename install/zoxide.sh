#!/usr/bin/env bash
# linux 安装 zoxide
# https://github.com/ajeetdsouza/zoxide
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/fxtaoo/cmd/master/install/zoxide.sh)"
# bash -c "$(curl -fsSL https://proxy.fxtaoo.com/cmd/install/zoxide.sh)"

set -eu

curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

shell_type=$(basename $SHELL)

if ! grep zoxide ~/.${shell_type}rc &> /dev/null;then
    cp ~/.${shell_type}rc  ~/.${shell_type}rc_b
    echo 'eval "$(zoxide init '$shell_type')"' >> ~/.${shell_type}rc
fi
