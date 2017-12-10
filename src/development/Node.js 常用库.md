# Node.js 常用库

<!-- TOC -->

- [Node.js 常用库](#nodejs-常用库)
    - [node-prune](#node-prune)

<!-- /TOC -->

## node-prune

> node-prune 是简单的用来移除 ./node_modules 中不必要文件的工具，譬如 MarkDown、TypeScript 源代码文件等；从而尽可能地减少 node_modules 中文件的体积，以加快应用部署的速度。

**安装**

```
go get github.com/tj/node-prune/cmd/node-prune
```

**使用**

在项目目录中，执行：
```
node-prune
```

node-prune会根据你的项目情况惊醒文件清理：
```
files total 27,330
files removed 3,990
size removed 13 MB
   duration 200ms
```

除了在项目目录中执行命令外，还可以指定特定目录
```
node-prune path/to/node_modules
```

或者在 package.json 的 scripts 字段中加入：
```json
  "scripts": {
    "postinstall": "node-prune"
  }
```

访问地址：[node-prune](https://github.com/tj/node-prune)


___
[Support By Lonly](mailto:lonly197@gmail.com)