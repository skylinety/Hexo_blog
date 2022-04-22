---
title: ES5与ES6中的argments
updated: 2018-01-24	16:17:53
date: 2018-01-24	15:14:56
tags: [总结]
categories: [JavaScript]
---
#### ES5

```js
function createArray5() {
    console.log(arguments)
    console.log(arguments instanceof Array)
    return arguments;
}
createArray5(11,2,3)
//(3) [11, 2, 3, callee: function, Symbol(Symbol.iterator): function]
//false
```

*****
#### ES6

```js
function createArray6(...args) {
    console.log(args)
    console.log(args instanceof Array)
    return args;
}

createArray6(11,2,3)
//  (3) [11, 2, 3]
//  true
```

#### 结论
* ES5的arguments是一种类数组。
* ES6通过扩展运算符获取到的参数是一个数组

> 本文作者： Skyline(lty)
本文链接： [http://www.skyline.show/ES5与ES6中的argments.html](http://www.skyline.show/ES5与ES6中的argments.html)
版权声明： 本博客所有文章除特别声明外，均采用 [CC BY-NC-SA 3.0 许可协议](https://creativecommons.org/licenses/by-nc-sa/3.0/)。转载请注明出处！
