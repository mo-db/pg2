#include <cassert>
#include <iostream>
#include <algorithm>

struct sequence {
	int min;
	int max;
	int step;
	int current;
};

struct transform_sequence {
	sequence *seq;
	int (*transform) (int);
};

sequence make_sequence(int min, int max, int step) {
	struct sequence *new_seq = new sequence;
	new_seq->min = min;
	new_seq->max = max;
	new_seq->step = step;
	new_seq->current = min;
	return *new_seq;
}
bool has_next(const sequence *seq) {
	return seq->current < seq->max;
} // does constexpr work here?

int next(sequence *seq) {
	int current = seq->current;
	seq->current += seq->step;
	return current;
}

transform_sequence make_transform_sequence(transform_sequence *seq, int (*transform) (int)) {
}

bool ts_has_next(const transform_sequence *seq) {
}

int ts_next(transform_sequence *seq) {
}

int main(int argc, char **argv) {
	int min, max, step;

	// if no step given as argument use default
	constexpr int k_default_step = 1;
	if (argc == 4) {
		min = atoi(argv[1]);
		max = atoi(argv[3]);
		step = atoi(argv[2]);
	} else if (argc == 3) {
		min = atoi(argv[1]);
		max = atoi(argv[3]);
		step = k_default_step;
	} else {
		std::cout << "no correct arguments" << std::endl;
		return 1;
	}
	// handle the capsulated sequence
	sequence seq = make_sequence(min, max, step);
	while (has_next(&seq)) {
		std::cout << next(&seq) << std::endl;
	}
	return 0;
}

// why not just use the make_sequence() function and have a transform function
// as a parameter to calculate step?
