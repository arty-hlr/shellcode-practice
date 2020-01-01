#!/bin/bash

if [ $# -lt 1 ]; then echo "Usage: compile.sh <file>"; exit; fi

nasm $1.s -o $1.sc
nasm -f elf64 $1.s
ld -o $1 $1.o 2> /dev/null
