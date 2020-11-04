#include <windows.h>
#include <stdio.h>

// bcdedit.exe /set nx AlwaysOff
// restart

// nasm-shell
// nasm -O0 -o shellcode.bin shellcode.asm

// visual C++ 2008 32 bits command prompt
// cl /GS- test.c
int main() {
    FILE *f;
    long fsize;
    char *shellcode;
    LPVOID lpalloc;

    f = fopen("C:\\Users\\User\\Documents\\shellcode-practice\\practice\\x86\\windows\\shellcode.bin","rb");
    if (f == NULL) {
        printf("Couldn't find shellcode.bin\n");
        exit(1);
    }
    fseek(f, 0, SEEK_END);

    fsize = ftell(f);
    fseek(f, 0, SEEK_SET); 
    shellcode = malloc(fsize + 1);
    fread(shellcode, 1, fsize, f);
    fclose(f);
    shellcode[fsize] = 0;

    lpalloc = VirtualAlloc(0,4096, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    memcpy(lpalloc, shellcode, strlen(shellcode));
    ((void(*)())shellcode)();

    return 0;
}