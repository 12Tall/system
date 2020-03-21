# system
操作系统开发相关

碎片化的时间下，越来越难以集中精神，不只是读书，甚至看视频都难以学习。

## 想象中的操作系统

1. BIOS 引导  
2. IP 定位到`0x7c00`  
3. 进入实模式  
    在实模式下，可以进行`1M` 以内的寻址，运行简单的程序  
4. 跳转至保护模式  
    保护模式下可以进行`4G` 的寻址，而且支持特权级，内存分页等功能  

讲到这里，好像就再也没有思路了。我觉得前面这些东西应该不是操作系统里面最重要的东西，虽然他们比较晦涩难懂。  

目前为止，遇到的最难的东西，是开发环境的配置了。Bochs、Qemu、Windows、Linux 的选择上。总想又快又好。
怎么才能理解呢？什么时候才能有一个比较确定的开发、调试思路呢？

## 开发环境  

目前的开发环境是：
    - OpenSUSE(wsl)
    - QEMU  
    - NASM、GCC、GDB

因为适应了Windows 的桌面，而`WSL` 又可以直接在Windows 下跑Linux 程序。这里选择`WSL 1` 即可，只要能跑GCC、NASM 以及其他一些Linux 指令即可，版本不重要，高版本反而可能会更不稳定。


## 实模式下的汇编语言  

    用到工具，注意路径：
    - nasm: `nasm boot.asm -o boot.bin` 
    - dd: `dd if=boot.bin of=boot.img bs=512 count=1`
    - qemu: `qemu-system-i386 -s -S boot.img`
    - gdb: `gdb -q -x .gdb`  # 可以将一系列指令合并到一个文件内，避免重复输入

```nasm
; boot.asm
org 0x7c00  ; 告诉编译器将程序加载到0x7c00 处

  ; jmp $  ; 这应该算是最简单的程序了

mov ax, cs  ; 初始化段基址，还是很重要的
mov ds, ax  ; ds = cs
mov es, ax  ; es = cs
call DispStr  ; 调用子程序
jmp $  ;

DispStr:
  mov ax, BootMessage
  mov bp, ax  ; ES:BP = 字符串地址
  mov cx, 0x0a  ; cx = 字符串长度
  mov ax, 0x1301  ; ah = 0x13, al = 0x01
  mov bx, 0x000c  ; 显示样式，页号0x00,黑底红字0x0c
  mov dl, 0
  int 0x10
  ret

BootMessage:
  db "Hello, OS World!"  ;

times 510 - ($-$$) db 0  ; 填充剩余空间

dw 0xaa55  ; 引导扇区的标识

```


