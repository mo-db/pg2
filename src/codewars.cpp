#include <iostream>
#include <cmath>
#include <cassert>

// ex_001
unsigned int countBits(unsigned long long n){
	unsigned int counter {};

	// my solution
	for (unsigned long long remainder {n}; remainder > 0; remainder /= 2) {
		if (remainder % 2 == 1) 
			counter++;
	}

	// better solution
	while (n) {
		counter += n & 1; // increment if uneven
		n = n >> 1; // divide by 2
	}

	return counter;
}

// while n is multiple digits long, 
// get the sum of all digits of n and save this sum as the new n
int digital_root(int n)
{
	while (n > 9) {
		int sum {};
		while (n > 0) {
			sum += n % 10;
			n /= 10;
		}
		n = sum;
	}
	return n;
}

int main() {
	int n { 195 };
	// std::cin >> n;
	std::cout << digital_root(n) << std::endl;
}
