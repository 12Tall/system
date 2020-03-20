extern choose  ; declare c function

[section .data]  ; define params
num1st dd 3
num2nd dd 4

[section .text]

global _start  ; export function _start is the OEP
global myprint ; export function for c program

_start:
        push dword[num2nd]
        push dword[num1st]
        call choose  ; call c-style function choose(num1st, num2nd)
        add esp, 8
        mov ebx, 0
        mov eax, 1
        int 0x80

myprint:
        mov edx, [esp+8]
        mov ecx, [esp+4]
        mov ebx, 1
        mov eax, 4
        int 0x80
        ret
