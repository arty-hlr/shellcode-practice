section .data
shell db '/bin/sh'

section .text
global _start

_start:
mov eax, 0xb
mov ebx, shell
mov ecx, 0x0
mov edx, 0x0
int 0x80

mov eax, 0x1
mov ebx, 0x0
