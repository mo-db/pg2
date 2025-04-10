#include <cassert>
#include <iostream>
#include <algorithm>

void print_seq(int v1, int v2, int step) {
	int v_max = std::max(v1, v2);
	int v_min = std::min(v1, v2);
	std::cout << "printing sequence from " << v_min << " to " << v_max <<
		" :" << std::endl;
	for (int seq = v_min; seq <= v_max; seq += step) {
		std::cout << seq << std::endl;	
	}
}

int main(int argc, char **argv) {
	// if no step given as argument use default
	constexpr int k_default_step = 1;
	if (argc == 4) {
		print_seq(atoi(argv[1]), atoi(argv[3]), atoi(argv[2]));
	} else if (argc == 3) {
		print_seq(atoi(argv[1]), atoi(argv[2]), k_default_step);
	} else {
		std::cout << "no correct arguments" << std::endl;
		return 1;
	}
	return 0;
}
