---
title: html5+移动支付配置（微信）
updated: 2018-01-24	16:17:53
date: 2017-07-30	15:14:56
tags: [示例]
categories: [H5+]
---
#### 准备
[先看官方文档，支付插件配置](https://ask.dcloud.net.cn/article/71)
#### 关键代码
（框架vue)

```js
data () {
    return {
      payType: '2',
      payTypes: [
       {
         // icon: 'http://dn-placeholder.qbox.me/110x110/FF2D55/000',
         key: '1',
         value: '支付宝'
       },
      {
        // icon: 'http://dn-placeholder.qbox.me/110x110/FF2D55/000',
        key: '2',
        value: '微信支付'
      }],
      channels: []
    }
  },
  methods: {
    /**
     * 获取服务
     */
    getSerivces() {
      let me = this;

      plus.payment.getChannels(function(channels){
          me.channels=channels;
      },function(e){
          alert("获取支付通道失败："+e.message);
      });
    },

    /* 支付 */
    pay(){
      let me = this;
      SelectPayType({orderNum: this.activeOrderNum, payType: this.payType}).then(res => {
        if (res.code == 101) {
          let channel,
            data = JSON.parse(res.data);

          var payType = me.payType == '1' ? 'alipay' : 'wxpay';

          me.channels.forEach(function(val) {
            val.id == payType && (channel = val)
          })

          plus.payment.request(channel, data, function(result){
            me.isShowPayTypes = false;
            plus.nativeUI.alert("支付成功！订单状态将在稍后更新，请不要重复付款",function(){
                back();
            });
            me.jump({name:'订单详情',query:{orderNum: me.activeOrderNum}})
          },function(error){
              plus.nativeUI.alert("支付失败：" + error.code);
          });
        } else {
          me.$vux.toast.show({
            text: res.message,
            type: 'warn'
          })
        }
      })
    }
  },

  mounted(){
    if(window.plus){
     this.getSerivces()
    }else{
    // getSerivces()
     // document.addEventListener('plusready', this.getSerivces,false)
    }
  }
```

```js
//selectPayType是请求支付需要相关字段，需要查看相关平台接口文档，本文为微信，返回的字段如下
{
    "package": "Sign=WXPay",
    "appid": "wx7xxxxxx4987f28",
    "sign": "51B0ADxxxxx4E480486C70BD64BF44E1D",
    "partnerid": "148xxx722",
    "prepayid": "wx2017xxxxxx2fc85d2cc3c0205143628",
    "noncestr": "k2xxxxx3X2D1O4YCz7Hn4s",
    "timestamp": "1503312709"
}
```

#### 问题解决
提示 支付失败：-100支付失败：[payment微信：-1] 的问题
* 微信支付不能真机调试，只能打包安装测试，因为要你app的真实签名，真机调试用的是dcloud的调试基座app的wx0411fa6a39d61297,如果嫌打包麻烦，你可以把后端返回的数据appid换成wx0411fa6a39d61297
* 安卓平台下，首先查看微信开放平台配置的参数与提交打包的参数是否一致，主要包括(应用签名、包名)，其中应用签名如果使用的DCloud公用证书则必须是“59201CF6589202CB2CDAB26752472112”。

![:Users:skyline:Desktop:Screen Shot 2017-08-21 at 19.26.08.jpg-content](http://ovhnd57o6.bkt.clouddn.com/D001D4A36782781AB0AB75A09E572E34.jpg-content)

![:Users:skyline:Desktop:Screen Shot 2017-08-21 at 19.25.59.jpg-content](http://ovhnd57o6.bkt.clouddn.com/ED1EE7E39B541D59C9849CDE59BC21A2.jpg-content)


> 本文作者： Skyline(lty)
本文链接： [http://www.skyline.show/html5+移动支付配置（微信）.html](http://www.skyline.show/html5+移动支付配置（微信）.html)
版权声明： 本博客所有文章除特别声明外，均采用 [CC BY-NC-SA 3.0 许可协议](https://creativecommons.org/licenses/by-nc-sa/3.0/)。转载请注明出处！
