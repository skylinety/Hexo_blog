---
title: js数组去重
updated: 2017-07-30	15:14:56
date: 2017-07-30	15:14:56
tags: [题目]
categories: [JavaScript]
---
#### 首先定义几个变量

```js
let papa = {name: 'me', sex: 'male'},
    mama = {name: 'she', sex: 'female'},
    age = [18, 28],
    family = [1, 1, '1', 'skyline', 'skyline', papa, papa, mama, {name: 'she', sex: 'female'}, {}, age, [18, 28], []]
    
family.length//13
```

*****
#### 我是一个正常人
使用循环

```js
function removeRepetition(arr) {
    let ret = [];

    for (let i = 0, j = arr.length; i < j; i++) {
        if (ret.indexOf(arr[i]) === -1) {
            ret.push(arr[i]);
        }
    }

    return ret;
}

function removeRepetition2(arr) {
    let ret = [];

    arr.forEach(function(e, i, arr) {
        if (arr.indexOf(e) === i) {
            ret.push(e);
        }
    });

    return ret;
}
```

解析：indexOf比较参数与数组每一项时候，使用的是严格等于，所以会少一个papa

```js
removeRepetition(family)
//(10) [1, "1", "skyline", {…}, {…}, {…}, {…}, Array(2), Array(2), Array(0)]
removeRepetition2(family)
//(10) [1, "1", "skyline", {…}, {…}, {…}, {…}, Array(2), Array(2), Array(0)]
```

![Screen Shot 2017-08-22 at 16.15.25.png-content](http://ovhnd57o6.bkt.clouddn.com/098FB62D522D7EF6E6A0FF816F4AB094.png-content)

****
#### 我有想法

```js
//使用对象
function removeRepetition3(arr) {
    let tmp = {},
        ret = [];

    for (let i = 0, j = arr.length; i < j; i++) {
        if (!tmp[arr[i]]) {
            tmp[arr[i]] = 1;
            ret.push(arr[i]);
        }
    }

    return ret;
}

//先排序
function removeRepetition4(arr) {
    let ret = [],
        end;

    arr.sort();
    end = arr[0];
    ret.push(arr[0]);

    for (let i = 1; i < arr.length; i++) {
        if (arr[i] !== end) {
            ret.push(arr[i]);
            end = arr[i];
        }
    }

    return ret;
}
```

解析：
* removeRepetition3仅适用于简单类型，对象产生的属性相同，是`{[object Object]: 1}`,所以只会保留第一个出现的对象， 数组产生的是[xx,xx,xx].toString()作为属性，[1,2]产生的是`{1,2: 1}`，同时数字型字符串会被干掉，仅适用于纯数字去重，灰常不推荐.将对象换成es6的map结构即可。参看removeRepetition6。
* removeRepetition4采用的是sort方法，该方法在不带参数的情况下，默认使用的是unicode字符表顺序，由此可能出现未知的问题，不推荐

```js
removeRepetition3(family)
//(5) [1, "skyline", {…}, Array(2), Array(0)]
```

![Screen Shot 2017-08-22 at 16.15.40.png-content](http://ovhnd57o6.bkt.clouddn.com/F0C137C8DC05D1FB2F4465FF48022AFC.png-content)

```js
removeRepetition4(family)
//(11) [Array(0), "1", 1, Array(2), Array(2), {…}, {…}, {…}, {…}, {…}, "skyline"]
```

![Screen Shot 2017-08-22 at 16.23.08.png-content](http://ovhnd57o6.bkt.clouddn.com/0A84B572DB69A3E819B9B3A0C2F2A8B5.png-content)

*****
#### 我会es6

```js
function removeRepetition5(arr) {
    return [...new Set(arr)]
    // return Array.from(new Set(array));
}

function removeRepetition6(arr) {
    let tmp = new Map(),
        ret = [];

    for (let i = 0, j = arr.length; i < j; i++) {
        if (!tmp.has(arr[i])) {
            tmp.set(arr[i], 1)
            ret.push(arr[i]);
        }
    }

    return ret;
}

removeRepetition5(family)
//(10) [1, "1", "skyline", {…}, {…}, {…}, {…}, Array(2), Array(2), Array(0)]
removeRepetition6(family)
//(10) [1, "1", "skyline", {…}, {…}, {…}, {…}, Array(2), Array(2), Array(0)]
```

解析： 
* ES6 提供了新的数据结构 Set。它类似于数组，但是成员的值都是唯一的，没有重复的值。
* ES6 提供了新的数据结构 Map。它类似于对象，也是键值对的集合，但是“键”的范围不限于字符串，各种类型的值（包括对象）都可以当作键。Map 的键实际上是跟内存地址绑定的，只要内存地址不一样，就视为两个键。
* 参考阮一峰大大的[Set和Map数据结构](http://es6.ruanyifeng.com/#docs/set-map)

![Screen Shot 2017-08-22 at 16.56.13.png-content](http://ovhnd57o6.bkt.clouddn.com/476D2C7EDEBB793FF91022A7903C89A2.png-content)

> 本文作者： Skyline(lty)
本文链接： [http://www.skyline.show/js数组去重.html](http://www.skyline.show/js数组去重.html)
版权声明： 本博客所有文章除特别声明外，均采用 [CC BY-NC-SA 3.0 许可协议](https://creativecommons.org/licenses/by-nc-sa/3.0/)。转载请注明出处！
