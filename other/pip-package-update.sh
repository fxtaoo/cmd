#!/bin/bash
# pip 包更新

old_list=$(pip3 list --outdated --format=freeze | awk -F "==" '{print $1}')

for e in $old_list ; do
  pip3 install -U $e
done