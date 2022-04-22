---
title: Javascript对象扩展、封印与冻结
updated: 2018-01-24	16:17:54
date: 2017-07-30	15:14:56
tags: [总结]
categories: [JavaScript]
---


####  扩展、封印与冻结
##### 要点
* Object.preventExtensions()禁止扩展，Object.isExtensible()检查是否可扩展
* Object.seal()封印对象，Object.isSealed()检查是否被封印
* Object.freeze()冻结对象，Object.isFrozen()检查是否被冻结
* 被冻结的对象一定被封印了；当一个被封印的对象所有自有（实例）属性的描述符writable改为false时，那么此时它也是被冻结的，通过isFrozen返回true
* 被冻结对象的访问器属性如果有set描述符，则它仍旧是可写的
* 冻结与封印只针对首层属性，如果对象包含对象属性，该属性下对象仍旧是乐意改变的

![freeze.png-content](http://ovhnd57o6.bkt.clouddn.com/8284EEDA9E61CD4DA3CA8A04281F2AB7.png-content)

##### 代码
`var c = d = {name: "skyline liu", age: "21", phone: "10086"}`
`Object.getOwnPropertyDescriptors(c)`
`Object.getOwnPropertyDescriptors(d)`
###### ☞ c、d属性的描述符

```js
{
    age: {
        value: "21",
        writable: true,
        enumerable: true,
        configurable: true
    },
    name: {
        value: "skyline liu",
        writable: true,
        enumerable: true,
        configurable: true
    },
    phone: {
        value: "10086",
        writable: true,
        enumerable: true,
        configurable: true
    }
}

```

`Object.freeze(c)` 
`Object.getOwnPropertyDescriptors(c)`
###### ☞c属性的描述符
<!--more-->

```js
{
    age: {
        value: "21",
        writable: false,
        enumerable: true,
        configurable: false
    },
    name: {
        value: "skyline liu",
        writable: false,
        enumerable: true,
        configurable: false
    },
    phone: {
        value: "10086",
        writable: false,
        enumerable: true,
        configurable: false
    }
}
```

`Object.seal(d)` 
`Object.getOwnPropertyDescriptors(d)`
###### ☞ d属性的描述符

```js
{
    age: {
        value: "21",
        writable: true,
        enumerable: true,
        configurable: false
    },
    name: {
        value: "skyline liu",
        writable: true,
        enumerable: true,
        configurable: false
    },
    phone: {
        value: "10086",
        writable: true,
        enumerable: true,
        configurable: false
    }
}
```

###### ☞ e的对象属性
想要e完全不可改变，可以通过一个递归来冻结所有属性

```js
var e = {a: {b:1}}
Object.freeze(e)
e.a.b = 2
e.a.b // 2
```

> 本文作者： Skyline(lty)
本文链接： [http://www.skyline.show/Javascript对象扩展、封印与冻结.html](http://www.skyline.show/Javascript对象扩展、封印与冻结.html)
版权声明： 本博客所有文章除特别声明外，均采用 [CC BY-NC-SA 3.0 许可协议](https://creativecommons.org/licenses/by-nc-sa/3.0/)。转载请注明出处！
