---
title: Jquery中的extend
updated: 2018-01-24	16:17:53
date: 2017-07-30	15:56:13
tags: [分析,jquery]
categories: [JavaScript]
---
#### Jquery源码
[Jquery extend 源码地址](https://github.com/jquery/jquery/blob/1472290917f17af05e98007136096784f9051fab/src/core.js#L121)
*****
#### 代码使用

```js
var x = {
    a: 1,
    b: { f: { g: 1 } },
    c: [ 1, 2, 3 ]
};

var y = $.extend({}, x),          //shallow copy
    z = $.extend(true, {}, x);    //deep copy

y.b.f === x.b.f       // true
z.b.f === x.b.f       // false
```

*****
#### 源码分析

```js
jQuery.extend = jQuery.fn.extend = function() {
    var src, //缓存目标对象属性
        copyIsArray, //标记被复制对象属性是否是数组
        copy, //缓存被复制对象属性
        name, options, clone,
        target = arguments[0] || {}, //目标对象，如果没有传入参数，则默认为空对象
        i = 1, //标记参数的位置
        length = arguments.length,
        deep = false; //深浅克隆标志

    // 处理深克隆
    if (typeof target === "boolean") {
        deep = target;

        // 如果第一个参数为布尔值，则目标对象顺移值第二个参数
        target = arguments[i] || {};
        i++;
    }

    //处理目标参数是非对象情况（注意第二个判断条件是由于typeof用于function返回的是'Function')
    // Handle case when target is a string or something (possible in deep copy)
    if (typeof target !== "object" && !jQuery.isFunction(target)) {
        target = {};
    }

    // 如果传入参数只有一个（任意）则直接赋值Jquery对象
    if (i === length) {
        target = this;
        i--;
    }

    for (; i < length; i++) {
        //undefined == null true
        // 处理非null与undefined值
        if ((options = arguments[i]) != null) {

            for (name in options) {
                src = target[name];
                copy = options[name];

                // 如果目标属性与被复制对象属性相等
                if (target === copy) {
                    continue;
                }

                // 如果是纯粹对象或数组，则递归调用。（通过 "{}" 或者 "new Object" 创建的是纯粹对象）
                if (deep && copy && (jQuery.isPlainObject(copy) || (copyIsArray = jQuery.isArray(copy)))) {
                    if (copyIsArray) {
                        copyIsArray = false;
                        clone = src && jQuery.isArray(src) ? src : [];

                    } else {
                        clone = src && jQuery.isPlainObject(src) ? src : {};
                    }

                    target[name] = jQuery.extend(deep, clone, copy);

                } else if (copy !== undefined) {
                    target[name] = copy;
                }
            }
        }
    }

    return target;
};
```

*****
####参考资料
[深入剖析 JavaScript 的深复制](http://jerryzou.com/posts/dive-into-deep-clone-in-javascript/)

> 本文作者： Skyline(lty)
本文链接： [http://www.skyline.show/Jquery中的extend.html](http://www.skyline.show/Jquery中的extend.html)
版权声明： 本博客所有文章除特别声明外，均采用 [CC BY-NC-SA 3.0 许可协议](https://creativecommons.org/licenses/by-nc-sa/3.0/)。转载请注明出处！
