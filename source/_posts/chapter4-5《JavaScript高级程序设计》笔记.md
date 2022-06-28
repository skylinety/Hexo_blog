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
#### 数组
##### 坑点
* 数组的length不是只读的，可以通过修改来设置长度
* 一般通过isArray来判断是否是数组，而不用instanceof

##### 方法
<!--more-->
###### ☞ 概述
（括号内的-表示可选参数）

|方法名      | 描述               | 参数                                      | 返回         | 是否修改原数组|
|------------|--------------------|--------------------------------------|--------------|---------------|
|push        | 逐个添加至数组屁股 | 任意（-）                                 | 数组新长度   | 是|
|pop         | 砍掉屁股一项       | 无                                        | 被砍掉的屁股 | 是|
|shift       | 砍掉第一项         | 无                                        | 被砍掉的第一 | 是|
|unshift     | 逐个添加至数组头部 | 任意（-）                                 | 数组新长度   | 是|
|reverse     | 反向重排           | 无                                        | 数组         | 是|
|sort        | 排序               | fn（-）                                   | 数组         | 是|
|concat      | 联结               | 任意（-）                                 | 新数组       | 否|
|slice       | 截取               | 开始位置（-），结束位置（-）              | 新数组       | 否|
|splice      | 删除、插入、替换   | 开始位置（-），结束位置（-），插入项（-） | 包含被删除的项的数组，没有则空数组 | 是|
|indexOf     | 查找位置           | 查找项（-），开始位置（-）                | 找到返回位置，否则-1 | 否|
|lastIndexOf | 反向查找           | 查找项（-），开始位置（-）                | 找到返回位置，否则-1 | 否|
|every       | 与迭代             | 迭代函数，this指向作用域（-）             | 布尔值       | 否|
|some        | 或迭代             | 迭代函数，this指向作用域（-）             | 布尔值       | 否|
|filter      | 迭代筛选           | 迭代函数，this指向作用域（-）             | 函数返回值为true的项组成的数组 | 否|
|map         | 迭代调整           | 迭代函数，this指向作用域（-）             | 函数返回值组成的数组 | 否|
|forEach     | 迭代循环           | 迭代函数，this指向作用域（-）             | 无           | 否|
|reduce      | 归并               | 归并函数，初始值（-）                     | 归并终值     | 否|
|reduceRight | 反向归并           | 归并函数，初始值（-）                     | 归并终值     | 否|

* 增删排改（push、pop、shift、unshift、reverse、sort、splice）会修改原数组
* 涉及遍历的方法（every、some、filter、map、forEach）第二个参数可以指定上下文

###### ☞ 分析

方法名   | 描述 
---------|------
sort     | 无参数时为每一项调用toString()方法，按返回的字符串首字母升序，有参数fn时fn接受两个参数，即数组的两项，根据fn返回值正负零来确定先后
concat   | 无参数时返回原数组副本，多个参数中如果有数组，数组每一项添加到新数组，其他类型直接添加
slice    | 无参数时返回原数组副本，两个参数表示截取开始结束位置，一个参数时表示开始位置截取到最末。参数为复数时，加上数组长度后截取，结束大于开始返回空数组
splice   | 前两项整数，第一项指定删除与插入的开始位置，第二项指定删除个数，之后项是依次插入的数据
indexOf  | 参数一到两个，第一项指定查找项，与数组中项对比时要求使用严格相等判定，第二个指定开始位置（可选）
every    | 通过对数组每一项执行函数后全返回true则返回true，否则false
some     | 通过对每一项执行函数后至少一项返回true则返回true，否则false
filter   | 返回通过对每一项执行函数后返回true的项组成的新数组
map      | 返回通过对每一项执行函数取返回值组成的新数组
reduce   | 归并函数接受4个参数：前一个值，当前值，项索引，数组对象。归并函数当前返回值作为第一个参数传给下一项

其他描述
* slice 截取，如果你跟我一样小学数学不好，每次都要掰手指，参考下图，截取就不会再有问题

```js
'skyline'.slice(1, 5) // "kyli"
['s', 'k', 'y', 'l', 'i', 'n', 'e'].slice(1, 5) // ["k", "y", "l", "i"]
```

![slice.png-content](http://ovhnd57o6.bkt.clouddn.com/C9242CC575DBEB3766C8D4A7FA053623.png-content)

* indexOf的严格判等

```js
var person = {name: 'skyline'}
var people = [{name: 'skyline'}]
var family = [person]
console.log(people.indexOf(person))// -1
console.log(family.indexOf(person))// 0
```

* 模拟栈，push + pop
* 模拟队列，shift + push
* 模拟反向队列，unshift + pop

*****
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
