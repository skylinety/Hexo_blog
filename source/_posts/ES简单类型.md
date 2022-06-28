---
title: ES简单类型
updated: 2022-06-22	15:16:25
date: 2022-06-21	18:02:02
tags: [JS,ES]
categories: [Major]
---
            
            

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

  - [Number](#number)
    - [NaN](#nan)
  - [Null](#null)

<!-- /code_chunk_output -->

## Number

### NaN

- NaN 的特征
  涉及 NaN 的操作返回 NaN
  NaN 不等于任何值，包括本身
- isNaN()
  isNaN 在接收到一个值以后会尝试将这个值转换成数字
  任何不能转换成数字的值都会导致该函数返回 true。

## Null

- null 表示空对象指针
- 如果定义的变量将来用于保存对象，建议初始化为 null 而不是其他值
