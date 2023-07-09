#!/usr/bin/env bash
# 生成 README.md

cloudflare_cdn="https://proxy.fxtaoo.dev/cmd/"
github="https://github.com/fxtaoo/cmd/blob/master/"

# 地址、注释
find install/* ops/* sys/* mac/* other/* file/* -print0 | xargs -0 -I% awk 'FNR==1 {print FILENAME} NR==2' % | sed 's/#//g' > /tmp/README.data

# 生成
data="# cmd

一些 shell 脚本
proxy.fxtaoo.dev 使用 Cloudflare CDN 代理 raw.githubusercontent.com"
head=""
head_next=""
while IFS=$'\n';read -r path;read -r intro; do
    head_next=${path%%/*}
    file_name=${path##*/}
    if [[ "$head" != "$head_next" ]];then
        # 从第二个新分类开始，添加  details
        if [[ $head != "" ]];then
                data="$data\n</details>\n"
        fi
        data="$data<details> <summary>$head_next</summary>\n\n| 文件名（github） | 介绍（cloudflare cdn） |\n| :- | :- |"
    fi
    # conf
    if [[ $head_next == "conf" ]];then
        data="$data\n| [$file_name]($github$path) | [$file_name]($cloudflare_cdn$path) |"
    else
        data="$data\n| [$file_name]($github$path) | [$intro]($cloudflare_cdn$path) |"
    fi
    head=$head_next
done < /tmp/README.data

echo -e "$data" > README.md
