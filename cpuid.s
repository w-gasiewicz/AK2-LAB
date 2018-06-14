.data

.text

.global cpuid
.type cpuid, @function

cpuid:	
	push %ebp
	mov %esp, %ebp

	#tutaj sobie ściągasz wartość ze zmiennej 'rejestr' z C
	mov 8(%ebp), %edi
	mov $1, %eax	

wersja:
	cmp $2, %edi
	je rdzenie
	

	cmp $3, %edi
	je wyposazenie

	
	cmp $4, %edi
	je wyposazenie_p
	
	cpuid
	push %eax
	jmp wyjscie

rdzenie:
	cpuid
	mov %ebx, %eax
	push %eax
	jmp wyjscie

wyposazenie:
	cpuid
	mov %ecx, %eax
	push %eax
	jmp wyjscie

wyposazenie_p:
	cpuid
	mov %edx, %eax
	push %eax
	jmp wyjscie

wyjscie:	
	mov %ebp, %esp
	pop %ebp
	ret
