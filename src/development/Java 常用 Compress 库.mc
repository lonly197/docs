# Java 常用 Compress 库

### 1 前言

本文主要介绍 gzip、deflate、lz4、snappy、lzo 等数据压缩库。

### 2 压缩方案

- Bzip2

bzip2 是 Julian Seward 开发并按照自由软件／开源软件协议发布的数据压缩算法及程序。Seward 在 1996 年 7 月第一次公开发布了 bzip2 0.15 版，在随后几年中这个压缩工具稳定性得到改善并且日渐流行，Seward 在 2000 年晚些时候发布了 1.0 版。bzip2 比传统的 gzip 的压缩效率更高，但是它的压缩速度较慢。

bzip2 使用 Burrows-Wheeler transform 将重复出现的字符序列转换成同样字母的字符串，然后用 move-to-front transform 进行处理，最后使用哈夫曼编码进行压缩。在 bzip2 中所有的数据块都是大小一样的纯文本数据块，它们可以用命令行变量进行选择，然后用从 π 的十进制表示得到的一个任意位序列标识成压缩文本。

- Deflater

DEFLATE 是同时使用了 LZ77 算法与哈夫曼编码（Huffman Coding）的一个无损数据压缩算法，DEFLATE 压缩与解压的源代码可以在自由、通用的压缩库 zlib 上找到，zlib 官网：http://www.zlib.net/
jdk 中对 zlib 压缩库提供了支持，压缩类 Deflater 和解压类 Inflater，Deflater 和 Inflater 都提供了 native 方法。

- Gzip

gzip 的实现算法还是 deflate，只是在 deflate 格式上增加了文件头和文件尾，同样 jdk 也对 gzip 提供了支持，分别是 GZIPOutputStream 和 GZIPInputStream 类，同样可以发现 GZIPOutputStream 是继承于 DeflaterOutputStream 的，GZIPInputStream 继承于 InflaterInputStream，并且可以在源码中发现 writeHeader 和 writeTrailer 方法。

- Lz4

LZ4 是一种无损数据压缩算法，着重于压缩和解压缩速度。它属于面向字节的 LZ77 压缩方案家族。

- Lzo

LZO 是致力于解压速度的一种数据压缩算法，LZO 是 Lempel-Ziv-Oberhumer 的缩写，这个算法是无损算法。

- Snappy

Snappy（以前称 Zippy）是 Google 基于 LZ77 的思路用 C++语言编写的快速数据压缩与解压程序库，并在 2011 年开源。它的目标并非最大压缩率或与其他压缩程序库的兼容性，而是非常高的速度和合理的压缩率。

### 3 性能对比

env:JDK:1.8/CPU:4C/Compress Times：2000times<br>

<table>
<tr><td>Format</td><td>Size Before(byte)</td><td>Size After(byte)</td><td>Compress Expend(ms)</td><td>UnCompress Expend(ms)</td><td>MAX CPU(%)</td></tr>
<tr><td>bzip2</td><td>35984</td><td>8677</td><td>11591</td><td>2362</td><td>29.5</td></tr>
<tr><td>gzip</td><td>35984</td><td>8804</td><td>2179</td><td>389</td><td>26.5</td></tr>
<tr><td>deflate</td><td>35984</td><td>9704</td><td>680</td><td>344</td><td>20.5</td></tr>
<tr><td>lzo</td><td>35984</td><td>13069</td><td>581</td><td>230</td><td>22</td></tr>
<tr><td>lz4</td><td>35984</td><td>16355</td><td>327</td><td>147</td><td>12.6</td></tr>
<tr><td>snappy</td><td>35984</td><td>13602</td><td>424</td><td>88</td><td>11</td></tr>
</table>
