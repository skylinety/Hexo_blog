---
title: chapter4-5《JavaScript高级程序设计》笔记
updated: 2017-07-29	20:58:25
date: 2017-05-22	20:58:25
tags: [笔记,高程]
categories: [JavaScript]
---
####  参考资料
>《JavaScript高级程序设计》

*********
#### 作用域链
* 作用域链的作用是保证最执行环境有权访问的所有变量和函数的有序访问
* 作用域链最前端始终都是当前代码所在环境的变量对象，而后一步一步向外成延伸，直到全局执行环境
* 标志符解析是沿着作用域链一级一级搜索的过程，直到找到为止，故而位于作用域链最前端的变量作为当前环境的变量


****

#### 正则
##### 定义
* 两种方式，对象字面量与构造函数
* 元字符需要进行转义
* RegExp构造函数接受两个参数。第一个是要匹配的字符串模式，第二个是可选的标识字符串
* 构造函数使用的模式字符串需要对元字符进行双重转义

举个栗子：
字面量定义： `/\.at\\skyline/gi`
构造函数定义： `new RegExp('\\.at\\\\skyline', 'gi')`

##### 方法
###### ☞ exec
专为捕获组设计，当匹配成功时，返回数组，**失败返回null**。返回的数组跟正则是否有子串（圆括号内，圆括号被称为捕获括号），是否全局，开始匹配的位置（lastIndex指定）有关。
代码1：非全局有子串

```js
var str="Skyline should be hardworking(Skyline up up up)"; 
var reg=/Sky(line)/;
console.log(reg.exec(str));
// ["Skyline", "line", index: 0, input: "Skyline should be hardworking(Skyline up up up)"]

console.log(reg.exec(str));
// ["Skyline", "line", index: 0, input: "Skyline should be hardworking(Skyline up up up)"]
```

未开启全局，此函数的作用和String类型的match()函数是一样的，只能够在字符串中匹配一次，如果没有找到匹配的字符串，那么返回null

代码2：全局有子串

```js

var str1="Skyline should be hardworking(Skyline up up up Skyline)"; 
var reg1=/Skylin(e)/g;
reg1.lastIndex = 8;
console.log(reg1.exec(str1));
// VM1002:4 (2) ["Skyline", "e", index: 30, input: "Skyline should be hardworking(Skyline up up up Skyline)"]
console.log(reg1.lastIndex);
// 37

console.log(reg1.exec(str1));
// VM1016:1 (2) ["Skyline", "e", index: 47, input: "Skyline should be hardworking(Skyline up up up Skyline)"]

console.log(reg1.exec(str1));
// VM1021:1 null

console.log(reg1.exec(str1));
// VM3222:1 (2) ["Skyline", "e", index: 0, input: "Skyline should be hardworking(Skyline up up up Skyline)"]
```

开启全局，此函数返回值同样是一个数组，并且也只能够在字符串中匹配一次。不过此时，此函数一般会和lastIndex属性匹配使用，此函数会在lastIndex属性指定的字符处开始检索字符串。**返回为null时。lastIndex重置为0**
****
#### 基本包装类型
##### 要点
* 包括Boolean、Number、String三种
* 创建方式包括转型函数（见下）和字面量
* 引用类型与基本包装类型的主要区别就是对象的生存期

##### 基本包装类型的对象生存期
###### ☞ 代码

```js
var s = 'skyline'
s.age = 23
console.log(s.age)
```

以上代码可以想象成如下JS代码周期
###### ☞ 图示

![基本包装类型.png-content](http://ovhnd57o6.bkt.clouddn.com/A724BE3A20AAF7086F2C651E8AF9E570.png-content)

当最后访问s.age时又创建了一个新的对象，故age不存在
##### 构造函数与转型函数

```js
var str = String('skyline')//转型函数，产生基本包装类型，相当于字面量创建
console.log(typeof str)//string
var obj = new String('skyline')//构造函数，产生引用类型
console.log(typeof obj)//object
```

##### 字符串的模式匹配方法
###### ☞ 概述
（括号内多参数','隔开，不同类型参数'/'隔开，括号内的-表示可选参数）

方法名      | 描述                   | 参数类型 | 参数说明 | 返回 
------------|------------------------|----------|----------|------
match       | 本质与正则exec相同     | regExp   |&nbsp;    | 与exec相同
search      | 查找字符串第一个匹配项 | regExp   |&nbsp;    | 字符串第一个匹配项索引，无则-1
indexOf     | 查找字符串第一个子字符 | str，开始位置（-）|&nbsp;    | 字符串第一个子字符串索引，无则-1
replace     | 替代字符串             | regExp/str, str/fn(...args)| 分别指定目标字符与替换字符| 替换后的字符串
split       | 指定分隔符分割字符串   | regExp/str, num(-)| 分别指定分隔字符与返回的数组长度| 分隔后所有字符组成的数组

###### ☞ 详解
replace
要替换所有子串，**第一个参数需要提供全局（g）标志的正则表达式。第二个参数是字符串时，可以使用字符序列表中的字符序列，将正则的到的值插入结果字符串；第二个参数是函数时，参数依次是匹配项，捕获组，匹配项位置，输入**

字符序列表

字符序列 | 正则属性 | 表意
---------| -------- | -----
$&       | regExp.lastMatch | 匹配整个模式的子串（匹配项）
$'       | regExp.leftContext | 匹配子串左边内容
$`       | regExp.rightContext | 匹配子串右边内容
$n       | regExp["$n"] | 匹配第n个捕获组子串

> 本文作者： Skyline(lty)
本文链接： [http://www.skyline.show/chapter4-5《JavaScript高级程序设计》笔记.html](http://www.skyline.show/chapter4-5《JavaScript高级程序设计》笔记.html)
版权声明： 本博客所有文章除特别声明外，均采用 [CC BY-NC-SA 3.0 许可协议](https://creativecommons.org/licenses/by-nc-sa/3.0/)。转载请注明出处！
