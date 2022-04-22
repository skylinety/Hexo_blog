---
title: displaynone和visibilityhidden的区别
updated: 2018-01-25	20:41:07
date: 2018-01-24    15:14:56
tags: [总结,css]
categories: [CSS/HTML]
---
#### 口述
简单来说都是用于隐藏元素。表现形式大有不同
  
display会被文档流给移除，会影响页面布局，页面重新排版，浏览器重绘，原本位置被其他元素占据。
  
visilibity:hidden不会被文档流给移除，不会影响布局，页面不会重新排版，浏览器只是重绘出一片空白
  
display不是继承属性，而visibility是继承属性。当子元素的visibility为visible时可以重置由先辈继承的visibility:hidden而变得可见。而元素的display属性设为none后子元素无力挣扎。

*****

#### 表述
  
样式|页面重绘|页面重排|显示效果|所在css属性是否继承
--|-------------------|--------------|-------|-----
display:none|是|是|无显示|否
visibility:hidden|是|否|所处区域空白|是

> 本文作者： Skyline(lty)
本文链接： [http://www.skyline.show/displaynone和visibilityhidden的区别.html](http://www.skyline.show/displaynone和visibilityhidden的区别.html)
版权声明： 本博客所有文章除特别声明外，均采用 [CC BY-NC-SA 3.0 许可协议](https://creativecommons.org/licenses/by-nc-sa/3.0/)。转载请注明出处！
