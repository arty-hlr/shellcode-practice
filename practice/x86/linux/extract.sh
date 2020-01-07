#!/bin/sh

if [ $# -lt 1 ]; then
    echo "Usage: extract.sh <file>"
    exit 0
fi

objdump -d "$1.o" | grep '[0-9a-f]:'| grep -v 'file'| cut -f 2 -d ':' | cut -f 1-6 -d ' ' | tr -s ' ' | tr '\t' ' ' | sed 's/ $//g' | sed 's/ /\\x/g' | paste -d '' -s | sed 's/^/"/' | sed 's/$/"/g'
