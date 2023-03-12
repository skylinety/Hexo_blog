#!/bin/bash

# auto deploy
# sh_path=$(dirname "$0")
sh_path=$(cd $(dirname $0); pwd)
echo $sh_path
base_dir="${sh_path%Hexo_blog/sh/modules}"
# echo $sh_path
. $sh_path/update_content.sh
# sh ./sh/modules/update_content.sh
hexo server