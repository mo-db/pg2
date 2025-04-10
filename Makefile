## BASE VARS
SRC_NAMES :=
SRC_DIR := src
OBJ_DIR := obj
BIN_DIR := bin

## COMPILER AND FILETYPE
CXX := clang++
CX := cc

## GENERATE VARS FROM SRC_NAMES
EXE := $(BIN_DIR)/a.out
SRC_FILES := $(addprefix $(SRC_DIR)/, $(addsuffix .$(CX), $(SRC_NAMES)))
OBJ_FILES := $(addprefix $(OBJ_DIR)/, $(addsuffix .o, $(SRC_NAMES)))
ASM_FILES := $(addprefix $(OBJ_DIR)/, $(addsuffix .s, $(SRC_NAMES)))

## FLAGS
BASE_FLAGS := -std=c++23 -I$(SRC_DIR)
# Create dependency files 
# If header changes, trigger recompilation of dependent source files
DEP_FLAGS := -MMD -MP
-include $(OBJ_FILES:.o=.d)
# Warning and Debug flags, debug flags need to be included when linking
WARNING_FLAGS := -Wall -Wextra -pedantic
DEBUG_FLAGS := -g -fsanitize=address,undefined

CXXFLAGS := $(BASE_FLAGS) $(DEBUG_FLAGS) $(WARNING_FLAGS) $(DEP_FLAGS) 
LDFLAGS := $(DEBUG_FLAGS) 

# Additional libraries
EXT_LIBS := sdl3

# Only call pkg-config if at least one external library is specified
ifeq ($(EXT_LIBS),)
	EXT_CFLAGS :=
	EXT_LDFLAGS :=
else
	EXT_CFLAGS := $(shell pkg-config --cflags $(EXT_LIBS))
	EXT_LDFLAGS := $(shell pkg-config --libs $(EXT_LIBS))
endif

CXXFLAGS += $(EXT_CFLAGS)
LDFLAGS += $(EXT_LDFLAGS)

## TARGETS
# Phony targets aren't treated as files
.PHONY: all run asm clean

# Default target, executed with 'make' command
all: $(EXE)

# Execute immediatelly after building
run: $(EXE)
	./$(EXE)

asm: $(ASM_FILES)
	@echo "Assembly files generated in $(OBJ_DIR): $(ASM_FILES)"

# Link all the objectfiles into an exe
$(EXE): $(OBJ_FILES) | $(BIN_DIR)
	$(CXX) $(LDFLAGS) $^ -o $@
	@dsymutil $@ 2>/dev/null || true  # macOS only, fails silently on other OS

# Pattern rule for .s files
$(OBJ_DIR)/%.s: $(SRC_DIR)/%.$(CX) | $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -S $< -o $@

# Pattern rule for .o files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.$(CX) | $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Make sure directories exist
$(OBJ_DIR) $(BIN_DIR):
	mkdir -p $@

# Clean for rebuilt - Using implicit variable RM (rm -f)
clean:
	$(RM) -r $(OBJ_DIR) $(BIN_DIR)

setup: $(OBJ_DIR) $(BIN_DIR)
	echo "CompileFlags:" > .clangd
	echo "  Add: [" >> .clangd
	@for flag in $(CXXFLAGS); do \
		echo "    \"$$flag\"," >> .clangd; \
	done
	echo "  ]" >> .clangd

	echo "/bin" > .gitignore
	echo "/obj" >> .gitignore

## Helper Legend
# normal-prerequisites | order-only-prerequisites (no out of date check)

## Automatic variables:
# $^: all prerequisites
# $<: first prerequisite
# $@: target

## Specifics
# -MDD, -MP: create .d files for header deps
# dsymutil: extract debug info (Mac only)

# Make always uses /bin/sh as shell
