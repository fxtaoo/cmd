#!/usr/bin/env bash
# centos 7 安装长期支持内核
# bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/centos-kernel-lts.sh)"
# bash -c "$(wget -qO - https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/centos-kernel-lts.sh)"

function kernel_update_centos(){
    rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
    yum install -y https://www.elrepo.org/elrepo-release-7.el7.elrepo.noarch.rpm

    cp /etc/yum.repos.d/elrepo.repo /etc/yum.repos.d/elrepo.repo.bak
    sed -i "s/elrepo.org\/linux/mirrors.tuna.tsinghua.edu.cn\/elrepo/g" /etc/yum.repos.d/elrepo.repo

    yum -y --enablerepo=elrepo-kernel install kernel-lt kernel-lt-devel

    grub2-set-default 0
    grub2-mkconfig -o /etc/grub2.cfg
}
kernel_update_centos

