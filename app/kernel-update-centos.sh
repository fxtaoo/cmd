#!/usr/bin/env bash
# centos 内核升级到最新长期支持
# bash -c $(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/app/kernel-update-centos.sh)

function kernel_update_centos(){
    rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
    yum install https://www.elrepo.org/elrepo-release-7.el7.elrepo.noarch.rpm
    yum -y --enablerepo=elrepo-kernel install kernel-lt.x86_64 kernel-lt-devel.x86_64

    yum remove kernel-tools kernel-tools-libs
    yum --disablerepo=\* --enablerepo=elrepo-kernel install -y  kernel-ml-devel kernel-ml-tools kernel-ml-tools-libs kernel-ml-tools-libs-devel kernel-ml-headers

    grub2-set-default 0
    grub2-mkconfig -o /etc/grub2.cfg
}

kernel_update_centos

