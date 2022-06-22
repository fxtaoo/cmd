#!/usr/bin/env bash
# 磁盘分区开启挂载
# 如果指定的磁盘以挂载，不做更改
# bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/sys/set-disk-mount.sh)"
# bash -c "$(wget -qO - https://raw.fxtaoo.dev/fxtaoo/cmd/master/sys/set-disk-mount.sh)"

# 正确绿色
function echo_ok(){
  echo -e "\033[32m$1\033[0m"
  sleep 1
}

# 错误红色
function echo_error(){
  echo -e "\033[31m$1\033[0m"
  sleep 1
}


# 提示黄色
function echo_point(){
  echo -e "\n\033[33m$1\033[0m"
  sleep 1
}

# 开始蓝色
function echo_start(){
  echo -e "\033[34m$1\033[0m"
  sleep 1
}

# 追加配置
function echo_add(){
  echo -e "\033[36m$1\033[0m"
  sleep 1
}

# 输出退出
function error_exit(){
  echo_error $1
  sleep 1
  exit 1
}

function set_disk_mount(){
  echo_point "磁盘分区："
  local disk_name=$1
  local dir_name=$2
  lsblk
  # 磁盘名
  while : ; do
    echo
    if [[ $disk_name == '' ]] ; then
      read -rp "请输入磁盘名（eg:sdb，输入 n 不分区）：" disk_name
    fi
    if [[ $disk_name == 'n' || $disk_name == 'N' || $disk_name == 'no' ]] ; then
      echo_ok "手动退出，不操作磁盘"
      exit 1
    fi

    # 安全冗余，验证磁盘是否挂载目录，是否存在
    if [[ $(df -T | grep "$disk_name" ) != '' || $(lsblk | grep "$disk_name") == '' ]] ; then
      echo_error "\n$disk_name 磁盘不存在或者以挂载目录！请重新输入！"
      disk_name=''
      continue
    fi
    break
  done

  # 挂载文件夹
  while : ; do
    echo
    if [[ $dir_name == '' ]] ; then
      read -rp "请输入挂载目录(eg:data，挂载在 /data)：" dir_name
    fi
    if [[ -e "/${dir_name}" ]] ; then
      echo_error "目录 /${dir_name} 以存在！请重新输入！"
      dir_name=''
      continue
    fi
    mkdir "/${dir_name}"
    break
  done

  # 自动分区
  echo -e "n\n\n\n\n\nw\n" | fdisk /dev/$disk_name || error_exit "$disk_name 分区失败！"
  mkfs.ext4 "/dev/${disk_name}1" || error_exit "${disk_name}1 格式化失败！"

  # 挂载
  mount "/dev/${disk_name}1" "/${dir_name}" || error_exit "${disk_name}1 挂载到 $dir_name 失败！"

  # 开机挂载
  uuid=$(bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/sys/get-disk-uuid.sh) ${disk_name}1")
  if [[ -z $uuid ]] ; then
    error_exit "获取 ${disk_name}1 UUID 失败！"
  fi
  cp /etc/fstab "/etc/fstab.$(date +%Y%m%d%H%M%S).bak"
  echo "UUID=$uuid /${dir_name}                    ext4    defaults        0 0" >> /etc/fstab
  echo_ok "配置 磁盘 ${disk_name}1 挂载到目录 /${dir_name} 开机自动挂载"
}
set_disk_mount $1 $2

