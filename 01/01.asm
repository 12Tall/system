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
