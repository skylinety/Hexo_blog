---
title: chapter1-3《JavaScript高级程序设计》笔记
updated: 2017-07-29	20:56:32
date: 2017-05-11	20:56:32
tags: [笔记,高程]
categories: [JavaScript]
---
####  参考资料
>《JavaScript高级程序设计》


*****
#### JaveScript 由三部分构成
##### 图示

![js.png-content](http://ovhnd57o6.bkt.clouddn.com/19FC542247208E8D24C54AAC64D5A679.png-content)

***
#### script元素
##### async与defer
&nbsp;      |async                                                   |defer
------------|--------------------------------------------------------|------------------------------
描述	     |立即下载脚本，不妨碍其他操作，不依赖其他脚本，不阻塞文档|延迟脚本到文档被解析与显示之后
适用范围    |外部引入脚本	                                         |外部引入脚本
多个执行顺序|不保证顺序                                              |先后顺序

多个执行顺序：同时出现多个async或defer脚本
****
#### Null类型
<!--more-->
##### 要点
* null表示空对象指针
* 如果定义的变量将来用于保存对象，建议初始化为null而不是其他值

****

#### Boolean()调用或布尔值的隐式转换
##### 如表
数据类型    |转化成true         |转化成false
---------   |-------------------|----------------
String	     |非空字符           |""(空字符）
Number	     |非零               |0与NaN
Object      |非Null对象	    |null
Undefined   |无                 |undefined

**`Boolean(NaN) === false //true`**
***
#### NaN
##### 要点
* 涉及NaN的操作返回NaN
* NaN不等于任何值，包括本身

##### isNaN()
* isNaN在接收到一个值以后会尝试将这个值转换成数字
* 任何不能转换成数字的值都会导致函数返回true，各个类型转数字参考**类型隐式转换规则**

***
#### 类型隐式转换规则
##### 对象隐式转换成字符串或数字

![ObjectToOther.png-content](http://ovhnd57o6.bkt.clouddn.com/0E0B74FDA0F7561D3AF96126F84DD4B3.png-content)

##### 其他隐式转换
值             | 转化成字符串(调用String()) | 转化成数字(Number()) | 转化成布尔值
---------------|----------------------------|----------------------|-------------
undefined      | "undefined"                | **NaN**              | false
null           | "null"                     | **0**                | false
NaN            | "NaN"                      |                      | **false**
[]（空数组）   | ""                         | 0                    | **true**
""（空字符串） |                            | **0**                | false

***

#### 不同对象调用toString()得到的结果
##### 如表
&nbsp;|调用toString()
---------|---------------------
普通对象 | "[object Object]"
数组arr  | arr.join()
函数类   | 定义函数的代码
日期类   | 可读日期
正则对象 | 正则对象字面量的字符

如果数组的某一项的值是null或者undefined，join()方法返回的结果以空字符串连接
***

#### 不同对象调用valueOf()得到的结果
##### 要点
* 大多数对象，包括普通对象、数组、函数、正则简单返回对象本身
* 日期对象返回19700101以来的毫秒数值

***
#### 数值转换函数
##### Number()
* 其他类型转换为数字时调用的是Number()，故基本转换参考**类型隐式转换规则**
* 要返回数字，只接收**纯数字**字符串作为参数，允许前后有空格，中间不能有，否则返回NaN

##### parseInt()
* 只要非空格的第一个字符是**数字**，它就会尽可能长地进行转换，直到遇到空格会或非字母
* 如果第一个非空格字符是其他，则返回NaN
* 可接受两个参数，第二个参数指定进制

##### parseFloat()
* 只要非空格的第一个字符是**数字或小数点**，它就会尽可能长地进行转换，直到遇到空格会或非字母
* 如果第一个非空格字符是其他，则返回NaN
* 接受一个参数，**只解析十进制**
* 只解析一个小数点，第二个小数点号以后字符忽略

*****

#### 逻辑与与逻辑或
##### 要点
* 都是短路操作符，即是第一个操作数可以决定结果，就不会对第二个操作数求值
    * 与操作符，第一个求值是false，直接返回第一个操作数
    * 或操作符，第一个求值是true，直接返回第一个操作数
* null、NaN、undefined等求布尔值结果是false(本点适用于第一点，单独提出只是需要注意而已）
    * 故如果它们出现在与操作符第一个操作数，则直接返回它们
    * 如果它们出现在或操作符第一个操作数，则返回第二个操作数

*****
#### switch语句
##### 要点
* **switch使用的是全等判定**
* 通过为每个case语句后添加break来避免执行多个case的情况，合并多种情况时最好加入注释

****
#### function
##### arguments
* arguments是一个类数组
* 它的值永远与对应命名参数的值保持同步。当在函数内部修改了第n个参数a的值，他将会反应到a与arguments[n-1]保持同步
* 长度是由运行时传入参数个数决定的，而不是定义时

```js
function test(a, b, c){
    arguments[0] = {name: 'skyline'}
    arguments[1] = 2;
	c = 5;
	console.log(`a=${a}, b=${b}, 第三个参数的值是：${arguments[2]}, 参数的长度：${arguments.length}, 第一个参数与a是否相等：${arguments[0] === a}`)
}

test(1, {firstName: 'liu'}, '3', 3)
// a=[object Object], b=2, 第三个参数的值是：5, 参数的长度：4, 第一个参数与a是否相等：true
```

##### 参数传递
说明：图解与说明仅为了解释参数传递，计算机内存远比此复杂
 **函数的参数都是按值传递的，当传递引用类型的值时，会把这个值在内存中的地址复制给局部变量**,其实质就是把实参在内存中的数据传递给形参，基本类型拷贝了本身，引用类型拷贝的是引用的地址。
 进入函数时，通过值传递，形参obj2拷贝了实参obj1的内存数据，即是一个引用地址。
 关于按引用传递：（我的理解是传入是形参obj2直接记录实参obj1的内存地址，故而不管什么时候两者谁变化，都将影响另一方，有待考证）C#区分值传递和引用传递是方法参数前加ref，就是引用传递, 不加就是值传递。

###### ☞ 代码一：

```js
var str1 = 'aaa';
var num2 = 2;
var obj1 = {
    value: 1
};

function foo(obj2) {
    obj2.value = 2;
    console.log(obj2.value); //2
}
foo(obj1);
console.log(obj1.value) // 2
```

在函数执行`obj2.value = 2;`前后的内存状态

![参数传递2.png-content](http://ovhnd57o6.bkt.clouddn.com/1EC51AF775991E5CE78CDFB1F631FFA3.png-content)

###### ☞ 代码二：

```js
var str1 = 'aaa';
var num2 = 2;
var obj1 = {
    value: 1
};

function foo(obj2) {
    obj2 = 2;
    console.log(obj2); //2
}
foo(obj1);
console.log(obj1.value) // 2
```

在函数执行`obj2 = 2;`前后的内存状态

![参数传递3.png-content](http://ovhnd57o6.bkt.clouddn.com/ECA895C3DF1A9D70D84E0BC47E91F656.png-content)

> 本文作者： Skyline(lty)
本文链接： [http://www.skyline.show/chapter1-3《JavaScript高级程序设计》笔记.html](http://www.skyline.show/chapter1-3《JavaScript高级程序设计》笔记.html)
版权声明： 本博客所有文章除特别声明外，均采用 [CC BY-NC-SA 3.0 许可协议](https://creativecommons.org/licenses/by-nc-sa/3.0/)。转载请注明出处！
