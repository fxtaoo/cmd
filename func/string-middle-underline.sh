#!/usr/bin/env bash
# 中划线转下划线

function string_middle_underline(){
  local middle=$1
  echo "$middle" | sed 's/-/_/g'
}

# string_middle_underline "string-middle-underline"