#!/usr/bin/env bash
# 国内下载 kubeadm 所需镜像
# bash -c "$(curl -fsSL https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/kubeadm-config-images-china.sh)"
# bash -c "$(wget -qO - https://raw.fxtaoo.dev/fxtaoo/cmd/master/install/kubeadm-config-images-china.sh)"

function kubeadm_config_images_china(){
    local china="registry.cn-hangzhou.aliyuncs.com/google_containers/"
    local default="k8s.gcr.io/"
    for image in $(kubeadm config images list | cut -d '/' -f2) ; do
        docker pull $china$image
        docker image tag $china$image $default$image
    done
}
kubeadm_config_images_china
