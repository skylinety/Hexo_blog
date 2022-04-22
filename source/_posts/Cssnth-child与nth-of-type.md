---
title: Css中nth-child与nth-of-type
updated: 2017-07-30	15:14:56
date: 2017-07-30	15:14:56
tags: [css,总结]
categories: [CSS/HTML]
---
* E:nth-child(n) 是指找到E,并且E是他父亲的生出来的n儿子 [:nth-child demo](https://jsfiddle.net/skylinety/Lhs9pg6w/1/)
* E:nth-of-type(n) 是指找到E,并且E是他父亲的生出来的第n个E儿子 [:nth-of-type demo](https://jsfiddle.net/skylinety/zsx4j03g/)

其中n可以是整数（1，2，3）、关键字（even，odd）、可以是公式2n+1(奇数），n+5(大于等于5)，-n+5(小于等于5),而且**n值起始值0**.

> 本文作者： Skyline(lty)
本文链接： [http://www.skyline.show/Cssnth-child与nth-of-type.html](http://www.skyline.show/Cssnth-child与nth-of-type.html)
版权声明： 本博客所有文章除特别声明外，均采用 [CC BY-NC-SA 3.0 许可协议](https://creativecommons.org/licenses/by-nc-sa/3.0/)。转载请注明出处！
