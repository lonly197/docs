# Webpack 常用工具

<!-- TOC -->

- [Webpack 常用工具](#webpack-常用工具)
    - [bundle-buddy-webpack-plugin](#bundle-buddy-webpack-plugin)

<!-- /TOC -->

## bundle-buddy-webpack-plugin

> Bundle Buddy 是著名的能够发现多个 JavaScript Chunks/Splits 中重复冗余源代码的工具，从而方便我们选取合适的代码分割参数，来最终提升页面加载的性能。bundle-buddy-webpack-plugin 则是基于 Bundle Buddy 封装的 Webpack Plugin，方便我们集成到现有的开发流程中。

**安装**

```
## YARN
yarn add bundle-buddy-webpack-plugin --dev

## NPM
npm install bundle-buddy-webpack-plugin --save-dev
```

**使用**

只需要插件进入你的webpack配置，并将其传递给插件数组即可。

```
## webpack.config.js
const BundleBuddyWebpackPlugin = require("bundle-buddy-webpack-plugin");

module.exports = {
  // ...
  plugins: [
    new BundleBuddyWebpackPlugin({sam: true})
  ]

};
```

访问地址：[bundle-buddy-webpack-plugin](https://github.com/TheLarkInn/bundle-buddy-webpack-plugin)


___
[Support By Lonly](mailto:lonly197@gmail.com)