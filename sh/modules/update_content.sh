#! /bin/bash

# source_url=/Volumes/HaHa/WorkSpace/Skyline/Blog/Docs
# source_url=./md_backs


echo $sh_path

echo $base_dir

# 发布目录
public_url=$base_dir"Hexo_blog/source/_posts/"
echo "发布文章目录"$public_url
# public_url=/Volumes/HaHa/WorkSpace/Skyline/Hexo_blog/source/_posts/

# 笔记源仓库Blog目录，与博客仓库Hexo_blog放在统一目录下
source_url=$base_dir"Blog/Docs"
echo "文章源目录"$source_url
# source_url=/Volumes/HaHa/WorkSpace/Skyline/Blog/Docs

# read $1

# 第一个输入参数为空
if [ "$1" == "" ]; then
    echo "没有指定文章目录，使用默认文章目录： ${source_url}"
else
    source_url=$1
    echo "输入文章目录为： ${source_url}"
fi
# 判定目录是否存在，-f判定文件是否存在
if [ ! -d $source_url ]; then
    echo "找不到对应文章目录，请重新指定目录"
    exit
fi

echo "正在从${source_url}中向发布目录写入文章"

STR='GNU/Linux is an operating system'
SUB='Linux'

if grep "$SUB" <<<"$STR"; then
    echo "It's there"
fi
# 获取目录下git提交信息
git_info=$(cd $source_url && git diff --name-only --cached | xargs echo)
# git diff --name-only --cached  用于获取已git add的文件  Git list of staged files

function replace_str() {
    # 找出$source_url目录的第一层目录文件，并删除空格
    # tr 命令用于转换或删除文件中的字符
    dirs=$(find $source_url -depth 1 -type d | tr " " "\?")
    # echo $dirs
    # local categories=()
    # local categories="tags: []"
    for dir in $dirs; do
        files=$(find $dir -mindepth 1 -type f -name "*.md" | tr " " "\?")
        echo -e "$files\n"
        for file in $files; do
            local file_name=$(basename "$file" | sed 's/\([[:space:]]\)//g')
            if [[ "$git_info" == *"$file_name"* ]]; then
                # echo "$file_name 文章本次涉及新增或变更"
                local base_name=$(echo ${file_name%.*})
                local dir_name=$(dirname "$file" | sed 's/\([[:space:]]\)//g')
                local post=''$public_url''$file_name''
                echo $post
                local publish_date="date: $(date -v-6d +%F%t%T)"
                local top="top: "
                # 截取目录前缀，eval将字符串中内容作为命令执行
                local tag_source_str=$(eval 'echo $dir_name | cut -c'$(expr ${#dir} + 2)'-')
                # local tag_source_str=$(eval 'echo $dir_name | cut -c'$( (expr ${#dir} + 2))'-')
                # 目录字符中/替换为逗号
                tag_source_str=$(echo $tag_source_str | sed 's/\//,/g')
                # echo ${tag_source_str}
                # 字符串拼接，直接放在一起，不用+号
                local categories='categories: ['$(basename "$dir")']'
                local tags='tags: ['$tag_source_str']'
                # for value in "${categories[@]}"
                # do
                #      echo $value
                # done

                local lines=$(cat "$file" | wc -l)
                for i in $(echo $dir_name | tr "/" "\n"); do
                    echo $i
                done
                local IN=$dir_name
                #  internal field separator (IFS)
                IFS='/' read -ra ADDR <<<"$IN"
                echo ${#ADDR[@]}
                for i in "${ADDR[@]}"; do
                    echo "$i"
                done
                # echo ${dir_name%/*}
                # $(dirname "$file" | sed 's/${dir_name%/*}//g')
                # echo $dir_name | tr ${dir_name%/*} " "
                echo "${base_name} 共 ${lines} 行"

                if echo "$base_name" | grep -q -E '\$$'; then
                    echo "*************${file} 存疑，跳过发布*************\n"
                    continue
                fi

                # [ "/path/to/foo.txt" =~ .*txt$ ] && echo "true" || echo "false"  # 3元？
                if [ $lines -lt 20 ]; then
                    echo "*************${file} 行数小于20，跳过发布*************\n"
                    continue
                fi

                # grep 指令用于查找内容包含指定的范本样式的文件，如果发现某文件的内容符合所指定的范本样式，预设 grep 指令会把含有范本样式的那一列显示出来
                # head -n 展示前n行
                # 如果之前文件存在，则采用之前的数据
                if [ -f "$post" ]; then
                    echo "$file_name 文章本次变更"
                    publish_date=$(grep "date:" "${post}" | head -n 1)
                    top=$(grep "top:" "${post}" | head -n 1)
                    # tags=$(grep "tags:" "${post}" | head -n 1)
                    # categories=$(grep "categories:" "${post}" | head -n 1)
                else
                    echo "$file_name 文章本次新增"
                fi

                # 找到第一次出现'- ['字符的行标，供后续删除该行，避免发布产生该条目录
                # 对于正则表达式中的空格匹配使用[[:space:]]容易出错，可使用''将正则包裹，后直接输入空格即可，如下行'/- \[/='，其中=为接入调整的文件，其前面为正则
                local h1=$(sed -n '/- \[/=' ${file} | sed -n '1p')
                
                # sed -e '${h1}d'发布文章后存在标题目录索引，删除该索引
                # sed -e '1d' 发布文章后存在多余标题，删除该标题
                # sed -e $h1'd;1d' -e '1i\ 由于第一行已被删除，指定第一行'1i\ 将没有任何效果，指定为2i

                if [[ "$h1" == '' ]]; then
                    echo '不存在索引目录'
                    h1=0
                else
                    echo '标题目录索引出现在第'$h1'行'
                fi
                sed -e $h1'd;1d' -e '2i\
---\
title: '"${file_name%.*}"'\
updated: '"$(date -v-6d +%F%t%T)"'\
'"${publish_date}"'\
'"${tags}"'\
'"${top}"'\
'"${categories}"'\
---\
            \
            ' "${file}" >back
                # ' -e 's/](resources/](https:\/\/cdn.jsdelivr.net\/gh\/skylinety\/blog-pics\/'${file_name%.*}'\/resources/g' "${file}" >back
                # ' -e 's/](resources/](http:\/\/ovhnd57o6.bkt.clouddn.com/g' -e 's/.png/.png-content/g; s/.jpg/.jpg-content/g;' "${file}" > back
                # 找出## 标题的数量，若数量超过2个，则该行数为line值，否则line值为空 sed -n指定输出内容
                local line=$(sed -n '/## /=' back | sed -n 3p)

                # -n 需要后续字符串长度非零
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
                # cat back >~/workSpace/own/blog/skyline-blog-hexo/blog/source/_posts/${file_name}
                # cat back >/Volumes/HaHa/WorkSpace/Skyline/Hexo_blog/source/_posts/${file_name}
                echo $file_name'写入发布目录成功'
                echo "------------------------------------------------------------------------\n"
                cat back >$public_url/${file_name}
                rm -rf back
            # sed -i '' 's/](http:\/\/ovhnd57o6.bkt.clouddn.com/](resources/g' "$file"
            fi

        done
    done
    # for value in "${categories[@]}"
    # do
    #      echo $value
    # done
    # ids=("a b" "c d")

    # echo ${ids[*]// /|}
    # a|b c|d

    # IFS='|';echo "${ids[*]}";IFS=$' \t\n'
    # IFS=',';echo "${categories[*]}";IFS=$' \t\n'
    # a b|c d
    # local categoryStr= IFS=',';echo "${categories[*]}";IFS=$' \t\n'

}

# ec -eho -n "请输入文件目录\n"
# read dir
replace_str

# sed流编辑器 s查找并替换 g全局替换 p打印
# sed 's/](resources/](http:\/\/ovhnd57o6.bkt.clouddn.com/gp' ~/Desktop/*/*.md 1>../source/_posts/test-my-site.md
# sed 's/](resources/](http:\/\/ovhnd57o6.bkt.clouddn.com/gp' ~/Desktop/*/*.md 1>~/Desktop/111.text
# cp ~/Desktop/*/*.md ../source/_posts/
