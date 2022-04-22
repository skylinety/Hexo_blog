---
title: vue里面的小坑
updated: 2017-12-30	15:14:56
date: 2017-12-30	15:14:56
tags: [总结]
categories: [Vue]
---
> [部分代码与文字源于官网，详情与变更参见官网，本文仅作参考](https://cn.vuejs.org)

#### 组件挂载顺序
##### 注意点
* vue子组件与父组件之间，父组件首先加载完成（beforeCreate->beforeMount率先执行）之后是子组件加载，最后由子向父组件挂载
* 要在所有组件生命周期完成后执行某个函数，只需要在父组件加入nextTick即可

vue代码结构如下

```xml
<template>
    <div class='papa'>
        <c1></c1>
        <c2></c2>
    </div>
</template>
<script>
export default {
    name: 'PaPa',
    
    components: {
        c1,
        c2
    },
    
    beforeCreate() {
      console.log('papa beforeCreate')
    },

    created() {
      console.log('papa created')
    },

    beforeMount() {
      console.log('papa beforeMount')
    },

    mounted(){
        console.log('papa mounted')
        this.$nextTick(() => {
            console.log('papa nextTick')
        })

        setTimeout(() => {
            console.log('papa setTimeout')
        })
    }
}
</script>
```

打印结果如下：
其中nextTick与setTimeout在生命周期的位置无关

![Screen Shot 2017-11-08 at 15.21.37.png-content](http://ovhnd57o6.bkt.clouddn.com/20981C34C327CF8ED10EE433FA51FE19.png-content)

*****

#### 关于computed
##### 简单说明
计算属性是基于它们的依赖进行缓存的。计算属性只有在它的相关依赖发生改变时才会重新求值。这就意味着只要依赖还没有发生改变，多次访问计算属性会立即返回之前的计算结果，这一定程度上节约了开销。
##### 关于setter
<!--more-->
需要注意的是，如果需要书写set函数，一般需要**变更计算属性相关依赖**

```js
// ...
computed: {
  fullName: {
    // getter
    get: function () {
      return this.firstName + ' ' + this.lastName
    },
    // setter
    set: function (newValue) {
      var names = newValue.split(' ')
      this.firstName = names[0]
      this.lastName = names[names.length - 1]
    }
  }
}
```

*****
#### $watch
##### 用法
观察 Vue 实例变化的一个表达式或计算属性函数。回调函数得到的参数为新值和旧值。表达式只接受监督的键路径。对于更复杂的表达式，用一个函数取代，或写在computed中，监听computed
##### 注意
$watch函数接受的第一个参数是属性名的字符串，一定要用引号，不能用变量来获取

```js
    data() {
        return {
            itemList: []
        }
    },
    mounted() {
        this.$nextTick(() => {

            this.$watch('itemList', function(n, v) {//不能写成this.itemList或直接写itemList
                
                this.mainPostList = _.takeWhile(n,function(o) {
                    return o.id == 18
                })
            })

        })
    }
```

为了发现对象内部值的变化，可以在选项参数中指定 deep: true 。注意监听数组的变动不需要这么做。

```js
vm.$watch('someObject', callback, {
  deep: true
})

```

在变异 (不是替换) 对象或数组时，旧值将与新值相同，因为它们的引用指向同一个对象/数组。Vue 不会保留变异之前值的副本。
*****
#### 资源引用
vue-html-loader 和 css-loader 认为没带根的路径为相对路径。官方为了让其看起来像模块路径, 加上了~前缀标志，表示让其从webpack配置中alias的相应项目取值，不加将找不到相应模块。

```js
//webpack
resolve: {
    extensions: ['.js', '.vue', '.json'],
    alias: {
      'vue$': 'vue/dist/vue.esm.js',
      '@': resolve('src'),
      '@assets': resolve('src/assets'),
      'static': resolve('static'),
    }
}
  
//less使用
<style lang="less">
       @import '~vux/src/styles/reset.less';
</style>
//dom使用
<img class="logo" src="~assets/logo.png-content">
```


> 本文作者： Skyline(lty)
本文链接： [http://www.skyline.show/vue里面的小坑.html](http://www.skyline.show/vue里面的小坑.html)
版权声明： 本博客所有文章除特别声明外，均采用 [CC BY-NC-SA 3.0 许可协议](https://creativecommons.org/licenses/by-nc-sa/3.0/)。转载请注明出处！
