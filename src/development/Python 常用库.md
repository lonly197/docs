# Python 常用库

<!-- TOC -->

- [Python 常用库](#python-常用库)
    - [Sanic](#sanic)

<!-- /TOC -->

## Sanic

> Sanic 是一个和类Flask 的基于Python3.5+的web框架，它编写的代码速度特别快。
除了像Flask 以外，Sanic 还支持以异步请求的方式处理请求。这意味着你可以使用新的 async/await 语法，编写非阻塞的快速的代码。

**安装**

```
pip install sanic
```

要使用bash安装不带uvloop或json的sanic，可以使用任何真值字符串（如“y”，“yes”，“t”，“true”，“on”，“1”和设置NO_X为true将停止该功能的安装。

```
SANIC_NO_UVLOOP=true SANIC_NO_UJSON=true pip install sanic
```

**使用**

示例代码：
```python
from sanic import Sanic
from sanic.response import json

app = Sanic()

@app.route("/")
async def test(request):
    return json({"hello": "world"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
```

访问地址：[Sanic](https://github.com/channelcat/sanic)


___
[Support By Lonly](mailto:lonly197@gmail.com)