#!/usr/bin/env bash
# 中划线转下划线

function convert_middle_underline(){
  local middle=$1
  echo "$middle" | sed 's/-/_/g'
}

# convert_middle_underline "string-middle-underline"