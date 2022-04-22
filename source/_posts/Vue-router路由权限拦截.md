---
title: Vue-router路由权限拦截
updated: 2017-09-30	15:14:56
date: 2017-05-30	15:14:56
tags: [vue-router,示例]
categories: [Vue]
---
#### 问题描述
路由跳转时，多数网站需要进行权限验证，其中最常见的就是登陆验证，如果没有权限，则会跳转到登陆页面。
本文进行在vue-router的基础上进行探讨。
***
#### 权限验证代码
因为大多数路由都需要进行验证，所以将下面函数加入全局混合的方法中，如果只是部分路由使用，可以只在组件中使用。除了跳转路由，为了方便其他ajax请求需要权限以及多数路由常用的验证，可以单独提出方法，如登录验证，角色验证

```js
// 为自定义的选项 'myOption' 注入一个处理器。 
Vue.mixin({
  methods: {
    /* 获取多页面的view与route */
    $viewUrl() {
        let loc = window.location
            // let pathname = loc.pathname.substring(7,loc.pathname.length)  //去掉views前缀
        let href = loc.href
        let url = encodeURIComponent(href) //编码转换
        return url
    },
    /* 多页面跳转 */
    $href(to, query) {
        let loc = window.location
        let env = process.env.NODE_ENV
        let url = ''
        if (env === 'development') {
            url = loc.protocol + '//' + loc.host + '/views/' + to
        } else {
            url = loc.protocol + '//' + loc.host + '/dist/views/' + to
        }
        url = query ? url + '?' + query : url
        console.log(url, to, query, "url")
        loc.href = url
    },
    /**
     * 权限验证
     * @param  {Array}  rules  eg: [{name: 'isAdmin', redirect: 'index/home'}, {name: 'isLogin', redirect: 'index/login'}] || ['isAdmin', 'islogin']
     * @param  {Object} status eg: {isActive: false, isLogin: true} 
     * @return {[type]}        [description]
     */
    $verifyRules(rules = [], status = {}) {
        // let status = Object.assign({}, store.getters.baseAccessinfo, store.getters.showSuplierInfo, store.getters.mengniu);
        typeof rules[0] == 'string' ? rules.forEach(val => {
            !status[val] && this.$href('index/index.html#/home')
        }) : rules.forEach(val => {
            !status[val.name] && this.$href(val.redirect || 'index/index.html#/home')
        })
    
    },
    
    /* 登录验证跳转 */
    $loginVerify() {
        let viewUrl = 'lastPath=' + this.$viewUrl
        this.$href('index/index.html#/login', viewUrl) // 将跳转的路由path作为参数，登录成功后跳转到该路由
    },
    /* 用户身份验证跳转 */
    $roleVerify() {
        let viewUrl = 'lastPath=' + this.$viewUrl
        this.$href('index/index.html#/join', viewUrl) // 将跳转的路由path作为参数，登录成功后跳转到该路由
    },      
  }
})

```

***
#### 路由设置

```js
const routes = [
    //顶层路由
    {
        path: '/userInfo',
        component: UserInfo,
        meta: {
            accessRules: ['isLogin'] //登录验证
        },
        children: [
            {
            name:'adminSys',
            path: '/adminSys',
            component: AdminSys,
            meta:{
               accessRules: [{name: 'isAdmin', redirect: 'index/toBeAdmin'}, {name: 'isLogin', redirect: 'index/login'}]//跳转到路由是否需要权限
            }          
        ]
    }
}]

```

***
#### 路由钩子

```js
/**
 * store.getters.userInfo.accessStatus = {isAdmin: false, isActive: false, isLogin: true}
 */
router.beforeEach((to, from, next) => {
    if (store.getters.userInfo.accessStatus.isAdmin) {
        let status = store.getters.userInfo.accessStatus,
            accessRules = Object.assign({}, ...to.matched.map(m => m.meta)).accessRules;//父路由accessRules应用于全部路由，当子路由设定有accessRules时，子规则覆盖父路由规则

        accessRules && vue.$verifyRules(accessRules, status);

        next();
    } else {
        vue.$roleVerify()
    }

})
```

> 本文作者： Skyline(lty)
本文链接： [http://www.skyline.show/Vue-router路由权限拦截.html](http://www.skyline.show/Vue-router路由权限拦截.html)
版权声明： 本博客所有文章除特别声明外，均采用 [CC BY-NC-SA 3.0 许可协议](https://creativecommons.org/licenses/by-nc-sa/3.0/)。转载请注明出处！
