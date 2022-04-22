---
title: Hbuilder打ipa包注意事项
updated: 2018-01-24	16:17:53
date: 2017-07-30	15:14:56
tags: [示例]
categories: [H5+]
---
#### 准备
在用hbuilder进行ipa打包之前，需要按照官方文档步骤生成证书文件

[iOS证书(.p12)和描述文件(.mobileprovision)申请](http://ask.dcloud.net.cn/article/152)
*****
#### 问题与解决方案

* 打包之后ipa文件通过iTunes安装，开始正常，安装到最后，图标消失，安装失败
  请确保设备在开发中心被添加，如下图所示

![:Users:skyline:Desktop:Screen Shot 2017-08-21 at 17.40.52.jpg-content](http://ovhnd57o6.bkt.clouddn.com/0ADA9EA02A43EB51D53D55635CB805E7.jpg-content)

****
* iOS开发者证书信息有误，请重新填写相关信息,iOS profile文件与私钥证书文件不匹配

![Screen Shot 2017-08-21 at 17.57.36.png-content](http://ovhnd57o6.bkt.clouddn.com/FF5BC2D570E96D42D0D5F12CED92285C.png-content)如果重新添加了账号，请重新生成证书相关文件，而不是使用原有的证书文件，按照官方文档生成证书步骤，重新来过。

> 本文作者： Skyline(lty)
本文链接： [http://www.skyline.show/Hbuilder打ipa包注意事项.html](http://www.skyline.show/Hbuilder打ipa包注意事项.html)
版权声明： 本博客所有文章除特别声明外，均采用 [CC BY-NC-SA 3.0 许可协议](https://creativecommons.org/licenses/by-nc-sa/3.0/)。转载请注明出处！
