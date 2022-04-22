---
title: Sed命令
updated: 2018-01-24 16:17:53
date: 2018-01-22    15:14:56
tags: [shell,总结]
categories: [Linux/Unix]
---
### 简介
流编辑器，sed用于读取指定文件或标准输入。如果没有文件被指定，可由命令列表来指定输入，进行相应修改后写入到标准输出。
*****
### 选项
#### -n
##### 概述
默认情况下，在所有的标准输出都会被打印到屏幕上。 -n选项用于指定输出内容。
##### 示例
###### ☞ 代码

```sh
# 输出100到200行
sed -n '100,200p' skyline.txt
# 输出文件行数
sed -n '$=' skyline.txt
```

###### ☞ 说明
<!--more-->
* 地址逗号隔开

*****
#### -e
##### 说明
-e是编辑命令，用于执行多个编辑任务。
##### 示例
###### ☞ 代码
`sed -e '1,10d' -e 's/skyline/lty/g' skyline.txt`
###### ☞ 说明
* skyline.txt将依次执行之后的命令，删除一到十行，并且全局替换'skyline'为'lty'

*****
#### -i
##### 概述
-i 指定备份，指定空字符串或不指定内容直接修改源文件(linux下可以不指定，mac下需指定空字符)。没有指定该选项将直接标准输出，不进行任何实质修改
##### 示例
###### ☞ 代码

```sh
# 指定skyline.txt.bak的备份
sed -i '.bak' 's/skyline/lty/g' ./skyline.txt
```

###### ☞ 说明
* skyline.txt源文件内容备份到skyline.txt.bak文件中
* sed -i '' 's/skyline/lty/g' ./skyline.txt 将不备份直接修改源文件
* sed -i 's/skyline/lty/g' ./skyline.txt linux可以直接执行修改源文件，mac下需要如上指定空字符方可，在 Mac 上，sed 命令直接操作文件的时候，必须指定备份的格式，而在 linux 上，却并没有这个要求

*****
### 命令参数
#### 插入i a
##### 概述
都是插入，后面可以接字串，用a插入的字串会在行的下一行行首出现，用i插入的字串会在当前行的行首出现单独一行需要在字符后加上\n
##### 示例
###### ☞ 代码

```sh
# Mac/Linux
sed -i '' '9i\
6666666' skyline.txt
# Linux
sed -i '' '9a\6666666' skyline.txt
```

###### ☞ 说明
* 注意mac下\后需要换行

*****

#### 删除d
##### 概述
删除，之后不接内容
##### 示例
###### ☞ 代码
`sed -i '' '1,2d' skyline.txt`
*****
#### 打印p
##### 概述
标准输出内容
##### 示例
###### ☞ 代码
`sed -n '3p' skyline`

*****
#### 替换 s c
##### 概述
替换部分内容，s来替换，通常这个 s 搭配正则表达式。 c 替换通常指定行，之后用这些字串取代 n1,n2 之间的行内容
##### 示例
###### ☞ 代码

```sh
# 替换1到5行的内容为lalala
sed -i '' '1,5c\
lalala' skyline.txt
# 替换
sed -i '' 's/666/222/g' skyline.txt
```

### 常见用法
* 文末插入 (注意mac下\后需要换行)
`sed -i '' '$a\skyline' skyline.txt`
* 替换第n个匹配的字符
`echo sksksksksksk | sed 's/sk/SK/3'`
* 输出文件行数
`sed -n '$=' skyline.txt`
* 输出文件第n个匹配字符所在行号
`sed -n /skyline/= skyline.txt | sed -n 2p #匹配第二个skyline，打印其所在行号`




> 本文作者： Skyline(lty)
本文链接： [http://www.skyline.show/Sed命令.html](http://www.skyline.show/Sed命令.html)
版权声明： 本博客所有文章除特别声明外，均采用 [CC BY-NC-SA 3.0 许可协议](https://creativecommons.org/licenses/by-nc-sa/3.0/)。转载请注明出处！
