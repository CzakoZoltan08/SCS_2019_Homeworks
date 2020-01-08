#include "pch.h"
#include <iostream>
#include <time.h>

static int static_arr[9] = {2, 5, 6, 7, 5, 2, 8, 10, 9};

void bubbleSort(int a[], int array_size){
	
	int i, j, temp;

	for (i = 0; i < (array_size - 1); ++i){
		for (j = 0; j < array_size - 1 - i; ++j){
			if (a[j] > a[j + 1]){
				temp = a[j + 1];
				a[j + 1] = a[j];
				a[j] = temp;
			}
		}
	}
}

void static_array() {
	
	clock_t start = clock();

	bubbleSort(static_arr, 9);

	clock_t stop = clock();

	double elapsed = (double)(stop - start) / CLOCKS_PER_SEC;
	printf("Time elapsed in ms: %f", elapsed);

	printf("\nThe sorted array: ");
	for (int i = 0; i < 9; i++) {
		printf("%d ", static_arr[i]);
	}
}

void dynamic_array(){

	int input = 0;
	int size = 0;				// size of array
	int *dynamic_arr = NULL;	// pointer to dynamic integer array

	printf("Enter elements of the dynamic_arr (Enter -1 to stop):\n");
	while (input != -1) {

		scanf_s("%d", &input);	// read the given number
		size++;					// increment the size of the dynamic array

		// allocate memory for the new element
		dynamic_arr = (int*)realloc(dynamic_arr, size * sizeof(int));

		if (dynamic_arr != NULL) {				// if memory allocation was successful
			dynamic_arr[size - 1] = input;		// store the given number in the array  
		} else {								// if there's an error allocating memory
			free(dynamic_arr);
			printf("Error reallocating memory");
			exit(1);     // exit with return code "1"
		}
	}

	clock_t start = clock();

	// sorting the dynamic array
	bubbleSort(dynamic_arr, size);

	clock_t stop = clock();

	double elapsed = (double)(stop - start) / CLOCKS_PER_SEC;
	printf("\nTime elapsed in ms: %f \n", elapsed);
	
	//printing the sorted list 
	printf("\nSorted list in ascending order:\n");
	for (int i = 0; i < size - 1; i++)
		printf("%d,", dynamic_arr[i]);

	free(dynamic_arr);  // release the allocated memory
}

int main(){
	// uncomment which must be used
	
	static_array();

	//dynamic_array();

	return 0;
}