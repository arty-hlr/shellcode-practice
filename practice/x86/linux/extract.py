#!/usr/bin/python3

from binascii import hexlify
import sys

if len(sys.argv) <= 1:
    print('Usage: extract <file>')
    exit()

f = sys.argv[1]+'.sc'
b = open(f,'rb').read()
h = hexlify(b).decode()
final = '"'
for i in range(0,len(h),2):
    final += '\\x'
    final += h[i:i+2]
final += '"'
print(final)
