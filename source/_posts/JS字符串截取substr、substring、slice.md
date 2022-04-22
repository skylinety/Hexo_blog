---
title: JS字符串截取substr、substring、slice
updated: 2018-01-24	16:17:54
date: 2017-07-30	16:02:42
tags: [总结]
categories: [JavaScript]
---
#### 代码

```js
var a = "skylinety"

a.slice(2,5)//"yli"

a.substr(2,5)//"yline"

a.substring(2,5)//"yli"
```

*****
#### 截取规则
1. 0s1k2y3l4i5n6e7t8y9
2. -9s-8k-7y-6l-5i-4n-3e-2t-1y0

s k y l i n e t y

0 1 2 3 4 5 6 7 8 9



#### 异同
* slice与substring截取规则基本相同，start,end
* substr截取规则，start,length
* slice中的start如果为负数，会从尾部算起，-1表示倒数第一个，-2表示倒数第2个
```
a.slice(-2,-5)//""

a.slice(-5,-2)//"ine"

a.slice(-5,8)//"inet"
```
* slice的start如果为正数,end如果为负数，end同样从尾部算起，如果其位置超过开始位置，返回空字符串
```
a.slice(5,-2)//"ne"
```
* substr第一个参数可正负，第二个参数表示，要截取的长度,若该参数为负数或0，都将返回空字符串
```
a.substr(-5,6)//"inety
```
* substring会取start和end中较小的值为start,二者相等返回空字符串，任何一个参数为负数被替换为0(即该值会成为start参数)
```
a.substring(-5,5)//"skyli"

a.substring(5,-5)//"skyli"

a.substring(-5,-4)//""
```


> 本文作者： Skyline(lty)
本文链接： [http://www.skyline.show/JS字符串截取substr、substring、slice.html](http://www.skyline.show/JS字符串截取substr、substring、slice.html)
版权声明： 本博客所有文章除特别声明外，均采用 [CC BY-NC-SA 3.0 许可协议](https://creativecommons.org/licenses/by-nc-sa/3.0/)。转载请注明出处！
