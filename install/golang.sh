#!/usr/bin/env bash
# golang 安装最新版本
# $1 指定 go 版本号（eg:go1.18.4），缺省最新
# $2 指定架构，缺省尝试自动获取
# bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/golang.sh)"
# bash -c "$(wget -qO - https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/golang.sh)"

set -e

download_site='https://go.dev/dl'
golang_version_api='https://go.dev'
if ! ping -c 1 google.com;then
    download_site='https://mirrors.aliyun.com/golang'
    golang_version_api='https://go.fxtaoo.dev'
fi

go_version=$1
type=$2


if [[ -z $go_version ]];then
 go_version=$(curl -fsSL ${golang_version_api}/VERSION?m=text)
fi

# golang 以安装，比较版本号
if which go >/dev/null 2>&1;then
  v1=${go_version#*.}
  v2=$(go version | awk '{print $3}')
  v2=${v2#*.}
  # v1 不大于 v2 结果 0，if 0 为真
  if awk -v v1=$v1 -v v2=$v2 'BEGIN{exit v1>v2}' ; then
    echo -e "当前 golang 版本 $v2 为最新\n"
    exit 0
  fi
fi


if [[ -z "$type" ]]; then
  case $(uname -s) in
    Linux)
      type=linux ;;
    *)
      echo "不支持 OS: $(uname -s)"
      exit 1 ;;
  esac

  case $(uname -m) in
    x86_64)
      type="${type}-amd64";;
    *)
      echo "不支持 arch: $(uname -m)"
      exit 1 ;;
  esac
fi

go_file_name="${go_version}.${type}.tar.gz"
go_file_path="/tmp/${go_file_name}"

wget ${download_site}/${go_file_name} -O $go_file_path

if [[ -e $go_file_path ]] ; then
  sudo rm -rf /usr/local/go && \
  sudo tar -C /usr/local -xzf $go_file_path
  rm -f $go_file_path
fi

# 七牛代理
if [[ $golang_version_api == 'https://go.fxtaoo.dev' ]] ; then
  (
    PATH="$PATH:/usr/local/go/bin"
    go env -w GO111MODULE=on
    go env -w GOPROXY=https://goproxy.cn,direct
  )
fi

