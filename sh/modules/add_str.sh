#! /bin/bash

baseUrl=./md_backs
words="hello world"
if [ "$1" == "" ]; then
echo "没有传参数，使用默认参数"
echo $baseUrl
else
baseUrl=$1
echo $1
fi

files=`find $baseUrl -mindepth 2 -maxdepth 4 -type f -name "*.md"`

for i in $files
do
    lines=`cat $i | wc -l`
    echo "${i} has ${lines} lines"
    if [ $lines -ge 100 ] ; then
        sed "100 a\
        <!--more-->
        " $i > back
    cat back > $i
    rm -f back
    fi
done