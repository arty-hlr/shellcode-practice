#!/usr/bin/python3
from pwn import *

context.log_level = 'warning'

if len(sys.argv) <= 1:
    log.warning('Usage: run.py shellcode.sc')
    exit()

try:
    shellcode = open(sys.argv[1],'rb').read()
except:
    log.warning("Couldn't open shellcode file, exiting")
    exit()

p = run_shellcode(shellcode)
p.interactive()
