---
title: word-break、overflow-wrap(word-wrap)、white-space
updated: 2018-01-24	16:17:53
date: 2017-12-30	15:14:56
tags: [css,总结]
categories: [CSS/HTML]
---
### 段落换行
**word-break 、overflow-wrap(word-wrap)**
#### overflow-wrap

```js
overflow-wrap: normal;
overflow-wrap: break-word;
```

word-wrap原始微软私有，css3之后重命名为overflow-wrap。
normal,默认值，单词保留完整，超出不管，CJK断行
break-word，尽量保留英文完整，从空白或CJK断开（单词一般是完整的，除非一个单词占一行才断开换行）

*****
#### word-break

```js
word-break: normal 
word-break: break-all 
word-break: keep-all
```

normal,默认值，单词保留完整，超出不管，CJK断行
break-all 超出即换行，不考虑单词完整（适用所有语言），就是挨着**把空白填满**
keep-all，**只有遇到空白**才断行（包括CJK），超出不管
*****
#### 换行总结
* normal 想的没错（你想的是哪样就是哪样）
* break-word 英文优先
* break-all 空白填满
* keep-all 空白断行
***

*****
### 处理文字空白
**white-space**
#### white-space
white-space设计用于处理段落中的空白符，处理换行问题时，涉及的是换不换行的问题，而不是怎么换行。常见使用是让文字直接不断行

&nbsp;  |换行符|空格和制表符|文字转行
--------|------|------------|----------
normal	 |合并	 |合并	       |转行
nowrap	 |合并	 |合并	       |不转行
pre     |保留  |保留	       |不转行
pre-wrap|保留  |保留        |转行
pre-line|保留  |合并        |转行
***
### 参考资料：
> [MDN white-space](https://developer.mozilla.org/zh-CN/docs/Web/CSS/white-space)

> 本文作者： Skyline(lty)
本文链接： [http://www.skyline.show/word-break、overflow-wrap(word-wrap)、white-space.html](http://www.skyline.show/word-break、overflow-wrap(word-wrap)、white-space.html)
版权声明： 本博客所有文章除特别声明外，均采用 [CC BY-NC-SA 3.0 许可协议](https://creativecommons.org/licenses/by-nc-sa/3.0/)。转载请注明出处！
