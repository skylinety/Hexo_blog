---
title: JavaScript隐式类型转换小结
updated: 2018-01-26	20:49:44
date: 2018-01-26	20:49:44
tags: [总结]
categories: [JavaScript]
---
>作者水平有限，文章仅供参考，不对的地方希望各位及时指正，共同进步，不胜感激

### 转换规则
#### 隐式转换为布尔值
##### 如表

数据类型    |转化成true         |转化成false
---------   |-------------------|----------------
String	     |非空字符           |""(空字符）
Number	     |非零               |0与NaN
Object      |非Null对象	    |null	       
undefined   |无                 |undefined

（注：调用Boolean()方法得到结果相同）
***
#### 对象隐式转换规则
<!--more-->
##### 对象隐式转换成字符串或数字

![0E0B74FDA0F7561D3AF96126F84DD4B3.png-content](http://ovhnd57o6.bkt.clouddn.com/0E0B74FDA0F7561D3AF96126F84DD4B3.png-content)

##### 不同对象调用toString()得到的结果

对象     |调用toString()
---------|---------------------
普通对象 | "[object Object]"
数组arr  | arr.join()
函数类   | 定义函数的代码
日期类   | 可读日期
正则对象 | 正则对象字面量的字符

* 如果数组的某一项的值是null或者undefined，join()方法返回的结果以空字符串连接
* 基本包装类型的引用类型用其字面量形式的值调用toString()

##### 不同对象调用valueOf()得到的结果

* 大多数对象，包括普通对象、数组、函数、正则简单返回对象本身
* 日期对象返回19700101以来的毫秒数值
* 基本包装类型的引用类型返回其字面量形式的值

****

#### 其他隐式转换规则

值             | 转化成字符串 | 转化成数字 | 转化成布尔值
---------------|-------------|----------------------|-------------
undefined      | "undefined"   | **NaN**              | false
null           | "null"     | **0**                | false
NaN            | "NaN"    | NaN                  | **false**
[]（空数组）   | ""           | 0                    | **true**
""（空字符串） | ""          | **0**                | false

* 布尔值转数字为0/1，转字符串为"true"/"false"
* 数字转字符串加引号即可🙄
* 字符串转数字，看去掉引号是否是数字即可🤣，否则为NaN
（注：假装这样表述是很严谨的🤣，数字与字符串的相互转换不用表述大家都知道的）

*****

### 开始转换

#### 加号

##### 表达式中有字符串
* 其他类型隐式转换为字符串
* 多个加号时，按照从左到右的顺序，两两进行计算
* 只要表达式中如果有字符串，最终结果一定是字符串
* 如果有复杂类型，先将复杂类型按照对象隐式转换规则转换成字符串

```js
2 + "3"; // "23"
1 + 2 + "3"; // "33"
true + 2 + "3"; // "33"
1 + "2" + 3; // "123"

"2" + true; //"2true"

"2" + undefined; //"2undefined"
"2" + NaN //"2NaN"
'23' + {'a': 1} //"23[object Object]"

'23' + [1,3,{}, null, undefined, '', '2'] // "231,3,[object Object],,,,2"
[1,3,{}, null, undefined, '', '2'].toString() //"1,3,[object Object],,,,2"
23 + "1,3,[object Object],,,,2" //"231,3,[object Object],,,,2"
```

##### 表达式中没有字符串
* 如果没有复杂类型，其他类型隐式转换为数字
* 如果有复杂类型，先将复杂类型按照对象隐式转换规则转换成原始值再按照如上规则计算

```js
1 + [] //"1"
1 + [1] //"11"
1 + {a:'a'} //"1[object Object]"
null + null //0
true + {a:'a'} //"true[object Object]"
```

* 注意undefined 转化成数字是NaN

```js
typeof NaN //"number"
null + undefined //NaN
1 + undefined //NaN
```

* 特殊注意

```js
+ '3'      // 数字3
```

*****
#### 乘，除，取余，减

* 其他类型会隐式转换为数字

```js
1 - '5' //-4
1 - [2, 2] //NaN
1 - {a:1} //NaN
1- undefined //NaN
1 - [] //1
1 - [2, 2] //NaN
1 - null //1
```

*****
#### 比较运算符部分 > < >= <= ==
* 数字vs其他，其他转化为数字
* 布尔值vs其他，布尔值转数字，数字vs其他
* 字符串vs字符串，按unicode依次比较(大写字母总是在小写字母之后)
* 对象vs数字，对象vs字符串，将对象转化为转换成原始值，再进行比较。
* 如果其中一个操作数是NaN，那么总是返回false(NaN和NaN是不相等的)
* null 只和undefined是好基友（互相相等）

```js
var x = NaN;
x === NaN; // false

undefined == "undefined" // false
null == "null" // false
null == 0 // false
null == false // false
undefined == 0 // false
undefined == false // false
```

*****

### 参考资料
>《JavaScript高级程序设计》

&nbsp;

> 本文作者： Skyline(lty)
文章链接： [http://www.skyline.show/JavaScript隐式类型转换小结.html](http://www.skyline.show/JavaScript隐式类型转换小结.html)
版权声明： 本博客所有文章除特别声明外，均采用 [CC BY-NC-SA 3.0 许可协议](https://creativecommons.org/licenses/by-nc-sa/3.0/)。转载请注明出处！
