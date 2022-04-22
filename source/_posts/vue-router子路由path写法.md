---
title: vue-router子路由path写法
updated: 2018-01-24	16:17:54
date: 2017-10-30	15:14:56
tags: [vue-router,总结]
categories: [Vue]
---
#### 代码
###### ☞ 不推荐写法

```js
{
    path: '/index',
    component: Index,
    children: [{
            path: '/home',
            name: 'home',
            component: Home
        }
    ]
}
```

###### ☞ 子路由

```js
{
    path: '/index',
    component: Index,
    children: [{
            path: 'home',
            name: 'home',
            component: Home
        }
    ]
}
```

子路由中不建议在path前加'/'绝对路径，容易造成误解（本意可能想要第二种结果）。如果需要在路由中隐藏'index'，改成如下写法
###### ☞ 路由隐藏index

```js
{
    path: '/',
    component: Index,
    children: [{
            path: 'home',
            name: 'home',
            component: Home
        }
    ]
}
```

#### 结果
<!--more-->
代码1 http://10.10.7.181:8060/#/home

代码2 http://10.10.7.181:8060/#/index/home

代码3 http://10.10.7.181:8060/#/home

> 本文作者： Skyline(lty)
本文链接： [http://www.skyline.show/vue-router子路由path写法.html](http://www.skyline.show/vue-router子路由path写法.html)
版权声明： 本博客所有文章除特别声明外，均采用 [CC BY-NC-SA 3.0 许可协议](https://creativecommons.org/licenses/by-nc-sa/3.0/)。转载请注明出处！
