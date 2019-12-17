#!/bin/bash

if [ $# -lt 1 ]; then echo "Usage: compile.sh <file>"; exit; fi

nasm $1.s -o $1.sc
nasm -f elf32 $1.s
ld -m elf_i386 -o $1 $1.o 2> /dev/null
