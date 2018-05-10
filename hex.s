STDIN=0
SYSREAD=3
SYSWRITE=4
STDOUT=1
SYSEXIT = 1
EXIT_SUCCESS = 0

.data
BUFLEN=512

.bss
.comm textin, 512
.comm textout, 512
.lcomm oneByte, 1

.text
threeBytes: .ascii "   "
threeBytes_len=.-threeBytes

.globl _start
_start:

read:
mov $SYSREAD, %eax
mov $STDIN, %ebx
mov $oneByte, %ecx
mov $1, %edx
int $0x80

mov oneByte, %r15d
mov %r15d, %r11d
#and $0x0F, %r11d
shr $4, %r11d
add $48, %r11d

mov %r11d, textout

write:
mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $textout, %ecx
mov $BUFLEN, %edx
int $0x80

mov %r15d, %r12d
and $0xF0, %r12d
#mov $0x10, %r14d
#div %r14d
#shl $4, %r12d
add $30, %r12d

mov %r12d, textout

write2:
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


