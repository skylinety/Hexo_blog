---
title: Generator函数
updated: 2017-11-29	20:58:25
date: 2017-11-29	20:58:25
tags: [总结]
categories: [JavaScript]
---
#### 例子
##### 代码1

```js
function* gen(x) {
  const y = yield x + 1;
  console.log(y, 'y'); // 12 "y"
  const z = yield y + 1;
  console.log(z, 'z'); // 12 "z"
  return z;
}

const g = gen(1);
const value = g.next().value; // 2

console.log(value); // 2
console.log(g.next(value + 10)); // {value: 13, done: true}
console.log(g.next(value + 10)); // {value: 12, done: true}

// 2
//12 "y"
// {value: 13, done: false}
//12 "z"
// {value: 12, done: true}
```

##### 代码2

```js
function* gen(x){
  var z = yield x + 3; 
  console.log(`z is ${z}`)
  var y = yield x + 2;
  console.log(`y is ${y}`)
  return z + y;
}

var g = gen(1);
console.log(g.next()) 

console.log(g.next()) 

console.log(g.next())
// {value: 4, done: false}
// z is undefined
// {value: 3, done: false}
// y is undefined
// {value: NaN, done: true}
```

##### 代码3

```js
function* gen(x){
  var z = yield x + 3; 
  console.log(`z is ${z}`)
  var y = yield x + 2;
  console.log(`y is ${y}`)
  return z + y;
}

var g = gen(1);
g // gen {<suspended>}
g[Symbol.iterator] // ƒ [Symbol.iterator]() { [native code] }
var x = g[Symbol.iterator]()
x // gen {<suspended>}
x.next() // {value: 4, done: false}
x.next() // z is undefined {value: 3, done: false}
x.next() // y is undefined {value: NaN, done: true}
```

##### 分析
* **Generator 函数不同于普通函数执行它不会返回结果，返回的是一个指针对象（包含iterator接口，即拥有Symbol.iterator属性）**
* iterator 对象通过调用自身的 next 方法，保证游标后移，并且next方法返回一个包含了 value和 done（迭代器是否完成的布尔值）的对象。
* 关于next返回对象中的value值，假设有n个yield语句，**第n个value的值是第n个yield 语句后面表达式的值，第n+1个value的值是Generator函数的返回值，第n+2个以上的value值是undefined**
* yield 语句的值，比如上面代码1中的 y与z，是**下一次调用 next 传入的参数的值**，也就是 value + 10,如果此处next不传值，如代码2中，y与z就是undefined。反过来说，next 方法带有的参数可以传入 Generator 函数，作为上个阶段异步任务的返回结果（上一个yield 语句的值）
> 本文作者： Skyline(lty)
本文链接： [http://www.skyline.show/Generator函数.html](http://www.skyline.show/Generator函数.html)
版权声明： 本博客所有文章除特别声明外，均采用 [CC BY-NC-SA 3.0 许可协议](https://creativecommons.org/licenses/by-nc-sa/3.0/)。转载请注明出处！
