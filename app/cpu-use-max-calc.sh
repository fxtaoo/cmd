#!/usr/bin/env bash
# cpu 最大使用比例计算
# $1 最大使用比例，缺省 95%
# bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/app/cpu-use-max-calc.sh)"

function cpu_use_max_calc(){
    use_max=$1
    cpu_num=$(grep -c "processor" /proc/cpuinfo)
    cpu_num_use_max=$(awk "BEGIN{print $cpu_num*${use_max:=0.95}}")
    echo $cpu_num_use_max
}

cpu_use_max_calc $1

