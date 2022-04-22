#! /bin/bash

input=/Users/skyline/workSpace/own/blog/skyline-blog-hexo/blog/sh/modules/src.txt
# input=/Users/skyline/workSpace/skyline/Blog/Docs

if [ "$1" == "" ]; then
    echo "没有输入文件，使用默认文件： ${input}"
else
    input=$1
    echo "输入文件为： ${input}"
fi

function play() {
    # while read line; do # reading each line
    #     echo $line
    # done <"$input"
    local i="$(date +%F_%T)"
    echo $i
    for line in $(cat $input); do
        i="$(date +%F_%T)"
        sudo ffmpeg -i $line -bsf:a aac_adtstoasc -vcodec copy -acodec copy "video_${i}.mp4"

    done
}

play
