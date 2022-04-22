#! /bin/bash

baseUrl=./md_backs
# baseUrl=/Users/skyline/workSpace/skyline/Blog/Docs

if [ "$1" == "" ]; then
    echo "没有输入文件目录，使用默认文件目录： ${baseUrl}"
else
    baseUrl=$1
    echo "输入文件目录为： ${baseUrl}"
fi

echo "正在从${baseUrl}中向发布目录写入文件"

function replace_str() {
    # tr 命令用于转换或删除文件中的字符
    files=$(find $baseUrl -mindepth 1 -type f -name "*.md" | tr " " "\?")
    echo -e "$files\n"
    for file in $files; do
        local file_name=$(basename "$file" | sed 's/\([[:space:]]\)//g')
        local base_name=$(echo ${file_name%.*})
        local dir_name=$(dirname "$file" | sed 's/\([[:space:]]\)//g')
        local myPath='./source/_posts/'$file_name''
        local publish_date="date: $(date -v-6d +%F%t%T)"
        local tags="tags: []"
        local categories="categories: []"
        local lines=$(cat "$file" | wc -l)
        

        for i in $(echo $dir_name | tr "/" "\n"); do
            echo $i
        done
        echo -e "${base_name} 共 ${lines} 行"
        # read -p "Enter first string: " VAR1
        # read -p "Enter second string: " VAR2

        # if [[ "$VAR1" == "$VAR2" ]]; then
        #     echo "Strings are equal."
        # else
        #     echo "Strings are not equal."
        # fi

        if  echo "$base_name" | grep -q -E '\$$'; then
            echo -e "*************${file} 存疑，跳过发布*************\n"
            continue
        fi

        # [ "/path/to/foo.txt" =~ .*txt$ ] && echo "true" || echo "false"  # 3元？
        if [ $lines -lt 50 ]; then
            echo -e "*************${file} 行数小于50，跳过发布*************\n"
            continue
        fi

        # grep 指令用于查找内容包含指定的范本样式的文件，如果发现某文件的内容符合所指定的范本样式，预设 grep 指令会把含有范本样式的那一列显示出来
        # head -n 展示前n行
        # 如果之前文件存在，则采用之前的数据
        if [ -f "$myPath" ]; then
            publish_date=$(grep "date:" "${myPath}" | head -n 1)
            tags=$(grep "tags:" "${myPath}" | head -n 1)
            categories=$(grep "categories:" "${myPath}" | head -n 1)
        fi

        sed -e '1i\
            ---\
            title: '"${file_name%.*}"'\
            updated: '"$(date -v-6d +%F%t%T)"'\
            '"${publish_date}"'\
            '"${tags}"'\
            '"${categories}"'\
            ---\
            >作者水平有限，文章仅供参考，不对的地方希望各位及时指正，共同进步，不胜感激\
            \
            ' -e 's/](resources/](https:\/\/cdn.jsdelivr.net\/gh\/skylinety\/blog-pics\/'${file_name%.*}'\/resources/g' "${file}" >back
        # ' -e 's/](resources/](http:\/\/ovhnd57o6.bkt.clouddn.com/g' -e 's/.png/.png-content/g; s/.jpg/.jpg-content/g;' "${file}" > back

        local line=$(sed -n /###/= back | sed -n 4p)
        echo -e "------------\n"
        if [ $lines -ge 30 -a -n "${line}" ]; then
            sed -i '' "${line}"'a\
            <!--more-->
            ' back
        fi

        # sed -i '' '$a\
        #     \
        #     &nbsp;\
        #     \
        #     > 本文作者： Skyline(lty)\
        #     文章链接： [http://www.skyline.show/'"${file_name%.*}"'.html](http://www.skyline.show/'"${file_name%.*}"'.html)\
        #     版权声明： 部分图片源自网络，并已在图片下方标明，由于转载等诸多因素，图源可能不准确，侵删。本博客所有文章除特别声明外，均采用 [CC BY-NC-SA 3.0 许可协议](https://creativecommons.org/licenses/by-nc-sa/3.0/)。转载请注明出处！\
        #     ' back
        cat back >~/workSpace/own/blog/skyline-blog-hexo/blog/source/_posts/${file_name}
        rm -rf back
        # sed -i '' 's/](http:\/\/ovhnd57o6.bkt.clouddn.com/](resources/g' "$file"
    done
}

# ec -eho -n "请输入文件目录\n"
# read dir
replace_str

# sed流编辑器 s查找并替换 g全局替换 p打印
# sed 's/](resources/](http:\/\/ovhnd57o6.bkt.clouddn.com/gp' ~/Desktop/*/*.md 1>../source/_posts/test-my-site.md
# sed 's/](resources/](http:\/\/ovhnd57o6.bkt.clouddn.com/gp' ~/Desktop/*/*.md 1>~/Desktop/111.text
# cp ~/Desktop/*/*.md ../source/_posts/
