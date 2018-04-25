STDIN=0
SYSREAD=3
SYSWRITE=4
STDOUT=1
SYSEXIT = 1
EXIT_SUCCESS = 0

.data
BUFLEN=512
ASCII_ZERO=0x30
ASCII_NINE=0x39
ERROR: .ascii "Wprowadz prawidlowa liczbe!\n"
err_len=.-ERROR

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

mov %eax, %ecx
dec %ecx
xor %ebx, %ebx

jmp petla
 
petla:
# Operacja XOR-owanie kolejnych liter
movb textin(, %ebx, 1), %al
xor $0x20, %al
movb %al, textout(, %ebx, 1)
inc %ebx

cmp %ecx, %ebx
jl petla


wyswietl:
mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $textout, %ecx
mov $BUFLEN, %edx
int $0x80
jmp end_label


end_label:
mov $SYSEXIT, %eax
mov $EXIT_SUCCESS, %ebx
int $0x80
