#!/bin/bash
# cnetos 安装 kubeadm 初始化准备
# bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/centos-kubeadm.sh)"
# 脚本参考 https://kubernetes.io/zh/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

# 设置主机名
read -rp "输入系统名:" hostname
hostnamectl set-hostname $hostname

# 禁用交换分区
cp /etc/fstab /etc/fstab.b
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
swapoff -a

# 关闭防火墙
systemctl stop firewalld.service
systemctl disable firewalld.service

# 将 SELinux 设置为 permissive 模式（相当于将其禁用）
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

# 允许 iptables 检查桥接流量
cat <<EOF | tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

# 安装 docker
bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/centos-docker.sh)"

# 安装 kubeadm、kubelet 和 kubectl
cat <<EOF | tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
systemctl enable --now kubelet





