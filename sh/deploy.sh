#!/bin/bash

# auto deploy
rm -rf ~/workSpace/skyline-blog-hexo/blog/md_backs/*
sh /Volumes/HaHa/WorkSpace/Skyline/Hexo_blog/sh/modules/update_content.sh
# 切换node版本，并丢弃错误输出
n 10.24.1 2>/dev/null
cd /Volumes/HaHa/WorkSpace/Skyline/Hexo_blog
hexo clean
hexo g
hexo d 
n 14.19.0 2>/dev/null