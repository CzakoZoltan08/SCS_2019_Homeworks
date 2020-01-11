#include <iostream>
#include <stdio.h>
#include <Windows.h>
using namespace std;
#define rdtsc __asm __emit 0fh __asm __emit 031h
#define cpuid __asm __emit 0fh __asm __emit 0a2h


unsigned cycles_high1 = 0, cycles_low1 = 0;
unsigned cycles_high2 = 0, cycles_low2 = 0;
unsigned cpuid_time_high = 0, cpuid_time_low = 0, cpuid_time = 0;
unsigned __int64 temp_cycles1 = 0, temp_cycles2 = 0;
__int64 total_cycles = 0;
unsigned a = 10;
size_t length;

int result = 0;


void swap(int *xp, int *yp)
{
	int temp = *xp;
	*xp = *yp;
	*yp = temp;
}

// A function to implement bubble sort  
void bubbleSort(int arr[], int n)
{
	int i, j;
	for (i = 0; i < n - 1; i++)

		// Last i elements are already in place  
		for (j = 0; j < n - i - 1; j++)
			if (arr[j] > arr[j + 1])
				swap(&arr[j], &arr[j + 1]);
}



int main() {
	
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
			sub edx, cycles_high1
			mov cpuid_time_low, eax
			mov cpuid_time_high, edx
			popad
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
		//Section of code to be measured
		const char *nrFormat = "R: %d\n";

		__asm {
			/*pushad
			CPUID
			RDTSC

			mov cycles_high2, edx
			mov cycles_low2, eax*/

			//addition with two registers
			/*mov eax, 5
			mov edx, 6
			add eax, edx*/

			//addition with one register and one variable
			//add eax, a

			//multiplication
			/*mov eax, 3
			mov edx, eax
			mov edx,4
			mul edx
			push eax
			push nrFormat
			call printf
			ADD ESP, 8*/

			//fdivision with of st(0) with st(0); the result should be 1
			//fdiv st, st


			//fsubstract 
			//fsub st, st(3)



			popad

			/*RDTSC
			mov cycles_high1, edx
			mov cycles_low2, eax*/
		}

		/*static int array[5] = { 5,2,8,1,10 };
		bubbleSort(array, 5);*/
	

	length = 100; //for example
	int *array = new int[length];
	bubbleSort(array, length);
	


		temp_cycles1 = ((unsigned __int64)cycles_high1 << 32) | cycles_low1;
		temp_cycles2 = ((unsigned __int64)cycles_high2 << 32) | cycles_low2;
		cpuid_time = ((unsigned __int64)cpuid_time_high << 32) | cpuid_time_low;
		total_cycles = temp_cycles2 - temp_cycles1 - cpuid_time;
		//printf("%lld\n", temp_cycles1);
		//printf("%lld\n", temp_cycles2);
		cout << cpuid_time << endl;
		//printf("%lld\n", total_cycles);
	
	getchar();
	return 0;
}




