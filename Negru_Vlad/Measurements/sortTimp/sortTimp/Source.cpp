
#define rdtsc __asm __emit 0fh __asm __emit 031h
#define cpuid __asm __emit 0fh __asm __emit 0a2h
#include <iostream>
#include <algorithm>
#include <time.h>



int main()
{
	unsigned cycles_high1 = 0, cycles_low1 = 0, cpuid_high = 0, cpuid_low = 0;
	unsigned cycles_high2 = 0, cycles_low2 = 0;
	unsigned var = 2500000;
	unsigned __int64 temp_cycles1 = 0, temp_cycles2 = 0, cpuid_time = 0;
	__int64 total_cycles = 0;
	//compute the CPUID overhead
	__asm {
		pushad
		CPUID
		RDTSC
		mov cycles_high1, edx
		mov cycles_low1, eax
		popad
		pushad
		CPUID
		RDTSC
		popad
		pushad
		CPUID
		RDTSC
		mov cycles_high1, edx
		mov cycles_low1, eax
		popad
		pushad
		CPUID
		RDTSC
		popad
		pushad
		CPUID
		RDTSC
		mov cycles_high1, edx
		mov cycles_low1, eax
		popad
		pushad
		CPUID
		RDTSC
		sub eax, cycles_low1
		sbb edx, cycles_high1
		mov cpuid_low, eax
		mov cpuid_high, edx

		popad
		CPUID
	}

	cycles_high1 = 0;
	cycles_low1 = 0;
	//Measure the code sequence
	__asm {
		pushad
		CPUID
		RDTSC
		mov cycles_high1, edx
		mov cycles_low1, eax
		popad
	}
	
	unsigned int *a = (unsigned int*)malloc(100000 * sizeof(unsigned int));
	a[0] = 1000;
	
	int ok;
	do {
		ok = 1;
		for (int i = 0; i < 99999; i++)
			if (a[i] > a[i + 1])
				std::swap(a[i], a[i + 1]), ok = 0;
	} while (ok);


	__asm {
		pushad
		CPUID
		RDTSC
		mov cycles_high2, edx
		mov cycles_low2, eax
		popad
	}
	cpuid_time = ((unsigned __int64)cpuid_high << 32) | cpuid_low;
	std::cout << cpuid_time << "\n";
	temp_cycles1 = ((unsigned __int64)cycles_high1 << 32) | cycles_low1;
	temp_cycles2 = ((unsigned __int64)cycles_high2 << 32) | cycles_low2;
	total_cycles = temp_cycles2 - temp_cycles1 - cpuid_time;
	std::cout << total_cycles << "\n";
	std::cout << total_cycles / 3.50f / 1000000;
	getchar();
}