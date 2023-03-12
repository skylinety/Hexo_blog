#!/bin/bash

# auto deploy
rm -rf ~/workSpace/skyline-blog-hexo/blog/md_backs/*
# sh /Volumes/HaHa/WorkSpace/Skyline/Hexo_blog/sh/modules/update_content.sh
# 获取脚本执行目录
sh_path=$(cd $(dirname $0); pwd)
base_dir="${sh_path%Hexo_blog/sh}"
# echo $sh_path
# 执行脚本
. $sh_path/modules/update_content.sh

# 切换node版本，并丢弃错误输出
n 10.24.1 2>/dev/null
cd $sh_path/Hexo_blog
hexo clean
hexo g
if (hexo d); then
    echo '博客发布成功！'
    n 14.19.0 2>/dev/null
else
    echo '博客发布失败'
    n 14.19.0 2>/dev/null
    exit 2
fi

# cd /Volumes/HaHa/WorkSpace/Skyline/blog-pics
# git pull -r || true
