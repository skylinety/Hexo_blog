#! /bin/bash

baseUrl=./md_backs
words="hello world"

if [ "$1" == "" ]; then
echo "没有输入文件目录，使用默认文件目录： ${baseUrl}"
else
baseUrl=$1
echo "输入文件目录为： ${baseUrl}"
fi

echo "正在从${baseUrl}中向发布目录写入文件"

function replace_str() {
    files=`find $baseUrl -mindepth 2 -maxdepth 4 -type f -name "*.md" | tr " " "\?"`
    echo $files
    for file in $files
    do
        local file_name=`basename "$file" | sed 's/\([[:space:]]\)//g'`

        sed -e '1i\
            >本文首发于我的个人网站[http://www.skyline.show](http://www.skyline.show/'"${file_name%.*}"'.html)，欢迎各位大大访问.\
            >作者水平有限，文章仅供参考，不对的地方希望各位及时指正，共同进步，不胜感激
            ' -e 's/](resources/](http:\/\/ovhnd57o6.bkt.clouddn.com/g' -e 's/.png/.png-content/g; s/.jpg/.jpg-content/g;' "${file}" > back

        cat back > ~/Documents/blog/${file_name}
        rm -rf back
        # sed -i '' 's/](http:\/\/ovhnd57o6.bkt.clouddn.com/](resources/g' "$file"
    done
}

replace_str
