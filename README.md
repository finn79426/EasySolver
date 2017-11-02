# Easy CTF web problem solver

This tool is to solve CTF web baby first problem.

It will check robots.txt、.git/.svn、phpmyadmin、js、css、cookie、response header and body.

I'm so lazy. I don't like easy web problems :(

## How to use

find FLAG{xxxx}: `ruby EasySolver.rb --host=www.ctf.tw --key=FLAG`

find CTF{xxxx}: `ruby EasySolver.rb --host=ctf.kaibro.tw --key=CTF`

setting port: `ruby EasySolver.rb --host=ctf.kaibro.tw --key=FLAG --port=7788`

## Installation

1. ruby
2. colorize
3. git clone this repo

## Screenshot

![img](https://github.com/w181496/EasySolver/blob/master/demo.png)
