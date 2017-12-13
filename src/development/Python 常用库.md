# Python 常用库

<!-- TOC -->

- [Python 常用库](#python-常用库)
    - [Sanic](#sanic)
    - [aiohttp](#aiohttp)
    - [SnakeViz](#snakeviz)

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

1.保存到main.py文件，运行文件`python3 main.py`；

2.打开URL`http://0.0.0.0:8000`，可以看到网页显示`Hello World`信息。

访问地址：[Sanic](https://github.com/channelcat/sanic)

## aiohttp

> 用于Python3.5+和asyncio的异步HTTP客户端/服务器

**安装**

```
pip install aiohttp
```

您可能希望安装可选的cchardet库作为chardet的更快替代:

```
pip install cchardet
```

为了加速客户端API的DNS解析，您也可以安装aiodns。强烈建议使用此选项：

```
pip install aiodns
```

**使用**

客户端示例代码：
```python
import aiohttp
import asyncio
import async_timeout

async def fetch(session, url):
    with async_timeout.timeout(10):
        async with session.get(url) as response:
            return await response.text()

async def main():
    async with aiohttp.ClientSession() as session:
        html = await fetch(session, 'http://python.org')
        print(html)

loop = asyncio.get_event_loop()
loop.run_until_complete(main())
```

服务端示例代码：
```python
from aiohttp import web

async def handle(request):
    name = request.match_info.get('name', "Anonymous")
    text = "Hello, " + name
    return web.Response(text=text)

app = web.Application()
app.router.add_get('/', handle)
app.router.add_get('/{name}', handle)

web.run_app(app)
```

访问地址：[aiohttp](https://github.com/aio-libs/aiohttp/)

## SnakeViz

> SnakeViz是一个基于浏览器的图形浏览器，用于Python的cProfile模块的输出。它会把函数的运行情况以Html的形式展示出来,以便于性能分析。

SnakeViz是一个非常好的工具来检查一个python程序，并找出当一个函数被调用时发生了什么。

**安装**

```
pip install snakeviz
```

**使用**

如果您生成了一个名为program.prof的配置文件，您可以从命令行启动SnakeViz：

```
snakeviz program.prof
```

您可以在命令行使用cProfile模块为脚本创建配置文件：

```
python -m cProfile -o program.prof my_program.py
```

访问地址：[SnakeViz](https://jiffyclub.github.io/snakeviz/)

___
[Support By Lonly](mailto:lonly197@gmail.com)