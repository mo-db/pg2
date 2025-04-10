#include "std_lib_facilities.h"

int main() {
	cout << "errno: " << errno << endl;
	extern int errno;
	cout << "errno: " << errno << endl;
}
