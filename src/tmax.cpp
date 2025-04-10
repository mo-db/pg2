#include <iostream>

using namespace std;

template <typename NumberType>
NumberType Maximum(NumberType first, NumberType second) {
	if (first < second ){ 
		return second; 
	}
	return first;
}

int main() {
	cout << Maximum(42, 23) << endl;
	cout << Maximum(3.14F, 42.42F) << endl;
	cout << Maximum(3.14, 4.42) << endl;
}
