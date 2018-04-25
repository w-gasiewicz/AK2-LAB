STDIN=0
SYSREAD=3
SYSWRITE=4
STDOUT=1
SYSEXIT = 1
EXIT_SUCCESS = 0

.data
BUFLEN=512
tablia: .word 1
.bss
.comm textin, 512
.comm textout, 512

.text
tekst: .ascii "Wprowadz ciag liter: \n"
tekst_len=.-tekst

.globl _start
_start:

mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $tekst, %ecx
mov $tekst_len, %edx 
int $0x80

mov $SYSREAD, %eax
mov $STDIN, %ebx
mov $textin, %ecx
mov $BUFLEN, %edx
int $0x80

xor %r12d,%r12d #zakodowana wiadomosc
mov %eax,%r9d #dlugosc ciagu
dec %r9d
mov $0, %ecx

szyfrowanie:
mov textin(,%ecx,1), %r10d
add $1,%r10d
mov %r10d, textout(, %ecx, 1)
inc %r12d
inc %ecx
cmp %r12d, %r9d
jg szyfrowanie

mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $textout, %ecx
mov $BUFLEN, %edx
int $0x80
jmp end_label

end_label:
mov $SYSEXIT, %eax
mov $EXIT_SUCCESS, %edi
int $0x80
