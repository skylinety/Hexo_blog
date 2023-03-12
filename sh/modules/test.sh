#! /bin/bash
# 脚本测试文件
sh_path=$(dirname "$0")
echo $sh_path
echo "${sh_path%test.*}"
base_dir="${sh_path%Hexo_blog/sh/modules}"
echo $base_dir

# 发布目录
public_url=$base_dir"Hexo_blog/source/_posts/"
echo $public_url
# public_url=/Volumes/HaHa/WorkSpace/Skyline/Hexo_blog/source/_posts/

# 笔记源仓库目录，与博客仓库放在统一目录下
source_url=$base_dir"Blog/Docs"
echo $source_url
# source_url=/Volumes/HaHa/WorkSpace/Skyline/Blog/Docs
