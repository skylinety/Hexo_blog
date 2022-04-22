---
title: vue中使用ueditor
updated: 2018-01-24	16:17:54
date: 2017-07-30	15:14:56
tags: [ueditor,示例]
categories: [Vue]
---
### 主要问题
可以使用vue-ueditor插件，**但是需要单独解决上传文件后端配置的问题**。本文主要探讨上传配置的问题。
### ueditor组件
#### 创建ueditor组件

```js
<template>
  <div>
    <!--下面通过传递进来的id完成初始化-->
    <script :id="randomId"  type="text/plain"></script>
  </div>
</template>

<script>

//主体文件引入
import '../../../static/utf8-jsp/ueditor.config'
import '../../../static/utf8-jsp/ueditor.all'
import '../../../static/utf8-jsp/lang/zh-cn/zh-cn'
import api from 'service/apiConfig'

export default {
  props: {
    //配置可以传递进来
    // ueditorConfig:{}
  },
  data() {
    return {
      //每个编辑器生成不同的id,以防止冲突
      randomId: 'editor_' + (Math.random() * 100000000000000000),
      //编辑器实例
      instance: null,

      /*
      ueditor配置，如果有不同需求，也可从父组件传入，如这里去除了头部的地图，单图上传等功能
       */
      ueditorConfig: {
        toolbars: [
          [
            'fullscreen', 'source', '|', 'undo', 'redo', '|',
            'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',
            'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
            'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|',
            'directionalityltr', 'directionalityrtl', 'indent', '|',
            'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'touppercase', 'tolowercase', '|',
            'link', 'unlink', 'anchor', '|', 'imagenone', 'imageleft', 'imageright', 'imagecenter', '|', 'insertimage', 'emotion', 'scrawl', 'attachment', 'insertframe', 'insertcode', 'webapp', 'pagebreak', 'template', 'background', '|',
            'horizontal', 'date', 'time', 'spechars', 'snapscreen', 'wordimage', '|',
            'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols', 'charts', '|',
            'print', 'preview', 'searchreplace', 'drafts', 'help'
          ]
        ]
      }
    };
  },

  //此时--el挂载到实例上去了,可以初始化对应的编辑器了
  mounted() {
    /*
    重写上传路径，需要与服务器上传地址接口一致
     */
    UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
    UE.Editor.prototype.getActionUrl = function(action) {
      if (action == 'uploadimage' || action == 'uploadscrawl') {
        return api.apiItem + '/images/upload';
        // } else if (action == 'uploadvideo') {
        // return 'http://a.b.com/video.php';
      } else {
        return this._bkGetActionUrl.call(this, action);
      }
    }
    this.initEditor()
  },

  beforeDestroy() {
    // 组件销毁的时候，要销毁 UEditor 实例
    if (this.instance !== null && this.instance.destroy) {
      this.instance.destroy();
    }
  },
  methods: {
    initEditor() {
      //dom元素已经挂载上去了
      this.$nextTick(() => {
        this.instance = UE.getEditor(this.randomId, this.ueditorConfig);
        // 绑定事件，当 UEditor 初始化完成后，将编辑器实例通过自定义的 ready 事件交出去
        this.instance.addListener('ready', () => {
          this.$emit('ready', this.instance);
        });
      });
    }
  }
};
</script>
```

#### 使用ueditor组件

```js
<Ueditor @ready="editorReady" style="display:inline-block;width: 800px; height: 500px; margin: 0px auto;"></Ueditor>
```

*****
### 配置ueditor
github下载未经编译过的源码，因为会涉及修改打包前的代码。之后按照仓库readme用grunt打包生成代码即可。以下是主要文件的修改

#### `ueditor.config.js`

```js
/**
 * 编辑器资源文件根路径。它所表示的含义是：以编辑器实例化页面为当前路径，指向编辑器资源文件（即dialog等文件夹）的路径。
 * 鉴于很多同学在使用编辑器的时候出现的种种路径问题，此处强烈建议大家使用"相对于网站根目录的相对路径"进行配置。
 * "相对于网站根目录的相对路径"也就是以斜杠开头的形如"/myProject/ueditor/"这样的路径。
 * 如果站点中有多个不在同一层级的页面需要实例化编辑器，且引用了同一UEditor的时候，此处的URL可能不适用于每个页面的编辑器。
 * 因此，UEditor提供了针对不同页面的编辑器可单独配置的根路径，具体来说，在需要实例化编辑器的页面最顶部写上如下代码即可。当然，需要令此处的URL等于对应的配置。
 * window.UEDITOR_HOME_URL = "/xxxx/xxxx/";
 */
//根据如上提示，修改路径为ueditor代码放置路径
var URL = window.UEDITOR_HOME_URL || (process.env.NODE_ENV === 'production' ? '/dist/static/utf8-jsp/' : '/static/utf8-jsp/');

/**
 * 配置项主体。注意，此处所有涉及到路径的配置别遗漏URL变量。
 */
window.UEDITOR_CONFIG = {

    //为编辑器实例添加一个路径，这个不能被注释
    UEDITOR_HOME_URL: URL
    /**
     * serverUrl这里直接改成请求配置文件的地址，便于去除老的后台代码。
     * 对于上传文件等其他请求直接在ueditor组件修改即可。
     * 在打包后的ueditor代码，其中主目录下的jsp或php那一个目录将config.json提出放在根目录下后可删除，也可保留。
     * 如果删除文件夹，配置是serverUrl: URL + "config.json"
     */
    , serverUrl: URL + "jsp/config.json"

}
```

***
### 请求的处理
上面完成了基本的操作。但是对于跨域，请求参数设置还没有处理。
跨域问题。如果你的项目使用了代理(我的项目用的是"http-proxy-middleware"）不需要jsonp来实现跨域，你需要修改_src/core/utils.js

#### utils.js

```js
isCrossDomainUrl:function (url) {
    var a = document.createElement('a');
    a.href = url;
    if (browser.ie) {
        a.href = a.href;
    }
    return false;
    // return !(a.protocol == location.protocol && a.hostname == location.hostname &&
    // (a.port == location.port || (a.port == '80' && location.port == '') || (a.port == '' && location.port == '80')));
}
```

其他参数设置（对于多数上传，在dialogs文件夹下，在图片上传中，多图上传是dialogs里的image,单图上传是_src/plugins/simpleupload.js。以image为例说明。（ueditor上传私用的是webuploader这个插件，如果请求参数是公共的，可以在webuploader.js修改源码，但是ueditor引入的是webuploader.min.js,注意）

#### image.js
<!--more-->

```js
/**
 * 可以再头部或者data中添加你想添加的参数
 **/
uploader.on('uploadBeforeSend', function (file, data, header) {
    //这里可以通过data对象添加POST参数
    // header['X_Requested_With'] = 'XMLHttpRequest';
    header['hahaha'] = 'skyline';
});
/**
 * 将上传接口返回的参数改为ueditor设置的参数
 * 以便于在编辑器中正常显示
 **/
uploader.on('uploadSuccess', function (file, ret) {
  var $file = $('#' + file.id);
  var _ret = ret;
  ret = {'url':_ret.data,'state': _ret.code == '101' ? 'SUCCESS' : "FAIL" ,'title':'图片'}
  try {
      var responseText = (ret._raw || JSON.stringify(ret)),
          json = utils.str2json(responseText);
      if (json.state == 'SUCCESS') {
          _this.imageList.push(json);
          $file.append('<span class="success"></span>');
      } else {
          $file.find('.error').text(json.state).show();
      }
  } catch (e) {
      $file.find('.error').text(lang.errorServerUpload).show();
  }
});
```

> 本文作者： Skyline(lty)
本文链接： [http://www.skyline.show/vue中使用ueditor.html](http://www.skyline.show/vue中使用ueditor.html)
版权声明： 本博客所有文章除特别声明外，均采用 [CC BY-NC-SA 3.0 许可协议](https://creativecommons.org/licenses/by-nc-sa/3.0/)。转载请注明出处！
