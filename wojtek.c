#include <stdio.h>

extern unsigned int cpuid(int rejestr);


int main()
{
	unsigned int rejestr = 0;
	unsigned int informacje = 0;
	
	printf("Prosze podac cyfre:\n1-Informacja o wersji procesora\n2-Liczba rdzeni, identyfikacja kontrolera przerwań\n3-Wyposażenie procesora rozszerzenia\n4-Wyposażenie procesora\n");
	scanf("%d", &rejestr);
	
	informacje = cpuid(rejestr);
	
	
	printf("%u", informacje);
	return 0;
	}
