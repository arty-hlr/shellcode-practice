#!/bin/bash

if [ $# -lt 2 ] 
then
    echo "Usage: syscall -32/-64 <syscall>"
    exit
fi

if [ $1 = '-32' ]
then
    file='unistd_32.h'
    echo "syscall in eax"
    echo "args in ebx, ecx, edx, esi, edi, ebp"
else
    file='unistd_64.h'
    echo "syscall in rax"
    echo "args in rdi, rsi, rdx, r10, r8, r9"
fi

n=$(grep "_$2 " /usr/include/asm/$file | cut -d ' ' -f 3)
printf "0x%x - %d\n" $n $n

decl=$(man $2 | grep "$2(" | head -1 | cut -d ';' -f 1)
if [ ! $decl 2> /dev/null ]
then
    decl=$(man $2.2 | grep "$2(" | head -1 | cut -d ';' -f 1)
fi
echo $decl
