---
title: ls命令
updated: 2017-12-30	15:14:56
date: 2017-12-30	15:14:56
tags: [shell,总结]
categories: [Linux/Unix]
---
## ls命令

### 查询目录内容命令

`ls 【选项】【目录/文件】`
 

```js
➜  ~ ll
total 0
drwx------@  3 skyline  staff   102B  4  4 11:17 Applications
drwx------+ 16 skyline  staff   544B  5 11 17:52 Desktop
drwx------+ 11 skyline  staff   374B  4 18 09:33 Documents
drwx------+ 78 skyline  staff   2.6K  5 26 10:43 Downloads
drwxr-xr-x   4 skyline  staff   136B  5 11 10:17 ENV
drwxr-xr-x   5 skyline  staff   170B  4  5 15:30 HBuilder
drwxr-xr-x   3 skyline  staff   102B  4  5 15:30 HBuilderProjects
drwx------@ 64 skyline  staff   2.1K  5 22 14:18 Library
drwx------+  3 skyline  staff   102B  4  3 12:30 Movies
drwx------+  6 skyline  staff   204B  4 25 17:31 Music
drwx------+  3 skyline  staff   102B  5 22 14:19 Pictures
drwxr-xr-x+  5 skyline  staff   170B  4  3 12:30 Public
drwxr-xr-x   9 skyline  staff   306B  5 11 09:57 workSpace
```

### 命令解析
文件格式|所有者权限|群组权限|其他人权限|ACL权限|引用计数|所有者|所在组|大小|最后修改日期|文件名
--------|----------|--------|----------|-------|--------|------|------|----|------------|------
d|rwx|r-x|r-x|+  |5 |skyline | staff  | 170B | 4  3 12:30| Public

#### 权限11位 `rwxr-xr-x`  
+ 第1位代表文件类型:
  * -文件
  * d目录 
  * l软链接文件
  * b 装置文件里面的可供储存的接口设备(可随机存取装置)；
  * c 装置文件里面的串行端口设备，例如键盘、鼠标(一次性读取装置)

+ 接下来的字符中，以三个为一组，且均为『rwx』 的三个参数的组合。
  * [ r ]代表可读(read)
  * [ w ]代表可写(write)
  * [ x ]代表可执行(execute)


要注意的是，这三个权限的位置不会改变，如果没有权限，就会出现减号[ - ]而已。
以一个班级为所有用户为例举例说明：
`rwx` u所有者 skyline  
`r-x` g所属组 美眉  
`r-x` o其他人 大老爷们傻和尚  
`r`读 `w`写 `x`执行  
3,6,10这些数字代表引用计数  

`-a` 显示所有文件，包括隐藏文件  
`-la` 详细显示所有文件
`-d` 显示目录属性 
`-i` 显示文件inode编号
`-ld` 详细显示目录属性

对目录如果没有w权限，即使里面的文件有写权限，也不能对文件进行移动，重命名操作，此时，需要给目录加上w权限：`chmod +w`（注意此时cwd是此目录）


> 本文作者： Skyline(lty)
本文链接： [http://www.skyline.show/ls命令.html](http://www.skyline.show/ls命令.html)
版权声明： 本博客所有文章除特别声明外，均采用 [CC BY-NC-SA 3.0 许可协议](https://creativecommons.org/licenses/by-nc-sa/3.0/)。转载请注明出处！
