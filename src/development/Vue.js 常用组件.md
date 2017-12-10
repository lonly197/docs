# Vue.js 常用组件

<!-- TOC -->

- [Vue.js 常用组件](#vuejs-常用组件)
    - [element-ui](#element-ui)
    - [vue-datasource](#vue-datasource)
    - [Vue-Quill-Editor](#vue-quill-editor)
    - [Vue-SimpleMDE](#vue-simplemde)
    - [Vue-Core-Image-Upload](#vue-core-image-upload)
    - [vue-echarts-v3](#vue-echarts-v3)
    - [vue-i18n](#vue-i18n)

<!-- /TOC -->

## element-ui ##
一套基于vue.js2.0的桌面组件库。访问地址：[element](http://element.eleme.io/#/zh-CN/component/layout)


## vue-datasource ##
一个用于动态创建表格的vue.js服务端组件。访问地址：[vue-datasource](https://github.com/coderdiaz/vue-datasource)

```JavaScript
<template>
	<div>
		<datasource language="en" :table-data="information.data"
	        :columns="columns"
	        :pagination="information.pagination"
	        :actions="actions"
	        v-on:change="changePage"
	        v-on:searching="onSearch"></datasource>
	</div>
</template>

<script>
	import Datasource from 'vue-datasource';					// 导入quillEditor组件
    export default {
        data: function(){
            return {
                information: {
	                pagination: {...},						// 页码配置
	                data: [...]
	            },
	            columns: [...],								// 列名配置
	            actions: [...]								// 功能配置
            }
        },
        components: {
            Datasource										// 声明组件Datasource
        },
	    methods: {
	        changePage(values) {...},
	        onSearch(searchQuery) {...}
	    }
	}
</script>
```


## Vue-Quill-Editor ##
基于Quill、适用于Vue2的富文本编辑器。访问地址：[vue-quill-editor](https://github.com/surmon-china/vue-quill-editor)

```JavaScript
<template>
	<div>
		<quill-editor ref="myTextEditor" v-model="content" :config="editorOption"></quill-editor>
	</div>
</template>

<script>
	import { quillEditor } from 'vue-quill-editor';			// 导入quillEditor组件
    export default {
        data: function(){
            return {
                content: '',								// 编辑器的内容
                editorOption: {								// 编辑器的配置
                    // something config
                }
            }
        },
        components: {
            quillEditor										// 声明组件quillEditor
        }
	}
</script>
```

## Vue-SimpleMDE ##
Vue.js的Markdown Editor组件。访问地址：[Vue-SimpleMDE](https://github.com/F-loat/vue-simplemde)

```JavaScript
<template>
    <div>
        <markdown-editor v-model="content" :configs="configs" ref="markdownEditor"></markdown-editor>
    </div>
</template>

<script>
    import { markdownEditor } from 'vue-simplemde';			// 导入markdownEditor组件
    export default {
        data: function(){
            return {
                content:'',									// markdown编辑器内容
                configs: {									// markdown编辑器配置参数
                    status: false,							// 禁用底部状态栏
                    initialValue: 'Hello BBK',				// 设置初始值
                    renderingConfig: {
                        codeSyntaxHighlighting: true,		// 开启代码高亮
                        highlightingTheme: 'atom-one-light' // 自定义代码高亮主题
                    }
                }
            }
        },
        components: {
            markdownEditor									// 声明组件markdownEditor
        }
    }
</script>
```

## Vue-Core-Image-Upload ##
一款轻量级的vue上传插件，支持裁剪。访问地址：[Vue-Core-Image-Upload](https://github.com/Vanthink-UED/vue-core-image-upload)

```JavaScript

<template>
    <div>
		<img :src="src">									// 用于显示上传的图片
        <vue-core-image-upload :class="['pure-button','pure-button-primary','js-btn-crop']"
           :crop="true"										// 是否裁剪
           text="上传图片"
           url=""											// 上传路径
           extensions="png,gif,jpeg,jpg"					// 限制文件类型
           @:imageuploaded="imageuploaded">					// 监听图片上传完成事件
		</vue-core-image-upload>
    </div>
</template>

<script>
    import VueCoreImageUpload  from 'vue-core-image-upload';	// 导入VueCoreImageUpload组件
    export default {
        data: function(){
            return {
                src:'../img/1.jpg'							// 默认显示图片地址
            }
        },
        components: {
            VueCoreImageUpload								// 声明组件VueCoreImageUpload
        },
        methods:{
            imageuploaded(res) {							// 定义上传完成执行的方法
                console.log(res)
            }
        }
    }
</script>

```

## vue-echarts-v3 ##
基于vue2和eCharts.js3的图表组件。访问地址：[vue-echarts-v3](https://github.com/xlsdg/vue-echarts-v3)

```JavaScript
<template>
    <div>
        <IEcharts :option="bar"></IEcharts>
    </div>
</template>
	
<script>
    import IEcharts from 'vue-echarts-v3';					// 导入IEcharts组件
    export default {
        data: function(){
            return {
                bar: {
			        title: {
			          text: '柱状图'							// 图标标题文本
			        },
			        tooltip: {},	
			        xAxis: {								// 横坐标
			          data: ['衬衫', '羊毛衫', '雪纺衫', '裤子', '高跟鞋', '袜子']
			        },
			        yAxis: {},								// 纵坐标
			        series: [{
			          name: '销量',
			          type: 'bar',							// 图标类型
			          data: [5, 20, 36, 10, 10, 20]
			        }]
			   	}
            }
        },
        components: {
            IEcharts								// 声明组件VueCoreImageUpload
        }
    }
</script>
```

## vue-i18n ##
一套基于vue.js2.0的多语言切换插件。访问地址：[vue-i18n](https://github.com/kazupon/vue-i18n)

```Javascript
// 入口main.js文件
    import VueI18n from 'vue-i18n'
    
    Vue.use(VueI18n)            // 通过插件的形式挂载
    
    const i18n = new VueI18n({
        locale: CONFIG.lang,    // 语言标识
        messages: {
            'zh-CN': require('./common/lang/zh'),   // 中文语言包
            'en-US': require('./common/lang/en')    // 英文语言包
        }
    })
    
    const app = new Vue({
        i18n,
        ...App
    }).$mout('#root')
    
    // 单vue文件
    <template>
        <span>{{$t('message.hello')}}</span>
    </template>
```

____
[Support By Lonly](mailto:lonly197@gmail.com)