#include "pch.h"
#include <iostream>
#include <time.h>

int is_prime(unsigned long n)
{

	for (unsigned long i = 2; i < n; i++)
	{
		if (n%i == 0) return 0;
	}
	return 1;
}

int main()
{
	clock_t start = clock();
	
	is_prime(60000);

	clock_t stop = clock();

	double elapsed = (double)(stop - start) * 1000.0 / CLOCKS_PER_SEC;
	printf("Time elapsed in ms: %f", elapsed);
}
