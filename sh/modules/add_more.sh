#! /bin/bash
# 如果文件行数大于200，打印1
if [[ (sed -n '$=' ~/Desktop/*/*.md) gt 200 ]]; then
    echo 1
fi
# sed 's/](resources/](http:\/\/ovhnd57o6.bkt.clouddn.com/g' ~/Desktop/*/*.md
# cp ~/Desktop/*/*.md ../source/_posts/