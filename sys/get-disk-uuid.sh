#!/usr/bin/env bash
# 磁盘 UUID
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/fxtaoo/cmd/master/sys/get-disk-uuid.sh)"
# bash -c "$(curl -fsSL https://proxy.fxtaoo.dev/cmd/sys/get-disk-uuid.sh)"

# $1 磁盘名
function get_disk_uuid(){
    # ls -lh /dev/disk/by-uuid | grep $1 | cut -d ' ' -f9
    if [[ -z $1 ]] ; then
        return 1
    fi
    uuid="$(lsblk -o name,uuid | grep $1 | cut -d ' ' -f2)"
    if [[ -z $uuid ]] ; then
        return 2
    fi
    echo $uuid
}
get_disk_uuid $1

