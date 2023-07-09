#!/bin/bash
# pip 包更新
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/fxtaoo/cmd/master/ops/pip-package-update.sh)"
# bash -c "$(curl -fsSL https://proxy.fxtaoo.dev/cmd/ops/pip-package-update.sh)"

old_list=$(pip list --outdated --format=freeze | awk -F "==" '{print $1}')

for e in $old_list ; do
  pip install -U $e
done
