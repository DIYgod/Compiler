# Compiler [![Build Status](https://travis-ci.org/DIYgod/Compiler.svg?branch=master)](https://travis-ci.org/DIYgod/Compiler)

A simple-C language compiler

---

## Introduction

Compile the simple-C program into machine code.

暂将实现分为11个阶段: 词法分析 语法分析 语义动作 语义分析 栈帧布局 翻译 规范化 指令选择 控制流分析 数据流分析 寄存器分配 代码流出.

已完成：词法分析 语法分析

相关内容：[各阶段源码](http://www.anotherhome.net/file/compiler/) [各阶段说明](http://www.anotherhome.net/1751)

## Requirements

+ Linux OS

+ GCC

+ Flex

    ```
    sudo apt-get install flex
    ```

+ Bison

    ```
    sudo apt-get install bison
    ```



## References

<dl>
    <dt>"Modern Compiler Implementation in C"</dt>
    <dd>http://www.cs.princeton.edu/~appel/modern/c</dd>
    
    <dt>"Modern Compiler Implementation in C"</dt>
    <dd>http://www.cs.princeton.edu/~appel/modern/c</dd>
    
    <dt>"ANSI C grammar (Lex)"</dt>
    <dd>http://www.quut.com/c/ANSI-C-grammar-l-1998.html</dd>
    
    <dt>"ANSI C grammar (Yacc)"</dt>
    <dd>http://www.quut.com/c/ANSI-C-grammar-y-1998.html</dd>
    
    <dt>"Lex和Yacc应用方法"</dt>
    <dd>http://www.cppblog.com/woaidongmao/archive/2008/09/20/62322.aspx</dd>
</dl>


## Keywords

```
Compiler Lex Yacc LLVM
```

## License

GPLv3
