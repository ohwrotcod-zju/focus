# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = "/Applications/CMake 2.8-7.app/Contents/bin/cmake"

# The command to remove a file.
RM = "/Applications/CMake 2.8-7.app/Contents/bin/cmake" -E remove -f

# The program to use to edit the cache.
CMAKE_EDIT_COMMAND = "/Applications/CMake 2.8-7.app/Contents/bin/ccmake"

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/sthennin/Projects/2dx

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/sthennin/2dx

# Include any dependencies generated for this target.
include kernel/mrc/lib/CMakeFiles/conv.dir/depend.make

# Include the progress variables for this target.
include kernel/mrc/lib/CMakeFiles/conv.dir/progress.make

# Include the compile flags for this target's objects.
include kernel/mrc/lib/CMakeFiles/conv.dir/flags.make

kernel/mrc/lib/CMakeFiles/conv.dir/2dx_conv.cpp.o: kernel/mrc/lib/CMakeFiles/conv.dir/flags.make
kernel/mrc/lib/CMakeFiles/conv.dir/2dx_conv.cpp.o: /Users/sthennin/Projects/2dx/kernel/mrc/lib/2dx_conv.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /Users/sthennin/2dx/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object kernel/mrc/lib/CMakeFiles/conv.dir/2dx_conv.cpp.o"
	cd /Users/sthennin/2dx/kernel/mrc/lib && /usr/bin/g++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/conv.dir/2dx_conv.cpp.o -c /Users/sthennin/Projects/2dx/kernel/mrc/lib/2dx_conv.cpp

kernel/mrc/lib/CMakeFiles/conv.dir/2dx_conv.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/conv.dir/2dx_conv.cpp.i"
	cd /Users/sthennin/2dx/kernel/mrc/lib && /usr/bin/g++  $(CXX_DEFINES) $(CXX_FLAGS) -E /Users/sthennin/Projects/2dx/kernel/mrc/lib/2dx_conv.cpp > CMakeFiles/conv.dir/2dx_conv.cpp.i

kernel/mrc/lib/CMakeFiles/conv.dir/2dx_conv.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/conv.dir/2dx_conv.cpp.s"
	cd /Users/sthennin/2dx/kernel/mrc/lib && /usr/bin/g++  $(CXX_DEFINES) $(CXX_FLAGS) -S /Users/sthennin/Projects/2dx/kernel/mrc/lib/2dx_conv.cpp -o CMakeFiles/conv.dir/2dx_conv.cpp.s

kernel/mrc/lib/CMakeFiles/conv.dir/2dx_conv.cpp.o.requires:
.PHONY : kernel/mrc/lib/CMakeFiles/conv.dir/2dx_conv.cpp.o.requires

kernel/mrc/lib/CMakeFiles/conv.dir/2dx_conv.cpp.o.provides: kernel/mrc/lib/CMakeFiles/conv.dir/2dx_conv.cpp.o.requires
	$(MAKE) -f kernel/mrc/lib/CMakeFiles/conv.dir/build.make kernel/mrc/lib/CMakeFiles/conv.dir/2dx_conv.cpp.o.provides.build
.PHONY : kernel/mrc/lib/CMakeFiles/conv.dir/2dx_conv.cpp.o.provides

kernel/mrc/lib/CMakeFiles/conv.dir/2dx_conv.cpp.o.provides.build: kernel/mrc/lib/CMakeFiles/conv.dir/2dx_conv.cpp.o

# Object files for target conv
conv_OBJECTS = \
"CMakeFiles/conv.dir/2dx_conv.cpp.o"

# External object files for target conv
conv_EXTERNAL_OBJECTS =

kernel/mrc/lib/libconv.a: kernel/mrc/lib/CMakeFiles/conv.dir/2dx_conv.cpp.o
kernel/mrc/lib/libconv.a: kernel/mrc/lib/CMakeFiles/conv.dir/build.make
kernel/mrc/lib/libconv.a: kernel/mrc/lib/CMakeFiles/conv.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX static library libconv.a"
	cd /Users/sthennin/2dx/kernel/mrc/lib && $(CMAKE_COMMAND) -P CMakeFiles/conv.dir/cmake_clean_target.cmake
	cd /Users/sthennin/2dx/kernel/mrc/lib && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/conv.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
kernel/mrc/lib/CMakeFiles/conv.dir/build: kernel/mrc/lib/libconv.a
.PHONY : kernel/mrc/lib/CMakeFiles/conv.dir/build

kernel/mrc/lib/CMakeFiles/conv.dir/requires: kernel/mrc/lib/CMakeFiles/conv.dir/2dx_conv.cpp.o.requires
.PHONY : kernel/mrc/lib/CMakeFiles/conv.dir/requires

kernel/mrc/lib/CMakeFiles/conv.dir/clean:
	cd /Users/sthennin/2dx/kernel/mrc/lib && $(CMAKE_COMMAND) -P CMakeFiles/conv.dir/cmake_clean.cmake
.PHONY : kernel/mrc/lib/CMakeFiles/conv.dir/clean

kernel/mrc/lib/CMakeFiles/conv.dir/depend:
	cd /Users/sthennin/2dx && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/sthennin/Projects/2dx /Users/sthennin/Projects/2dx/kernel/mrc/lib /Users/sthennin/2dx /Users/sthennin/2dx/kernel/mrc/lib /Users/sthennin/2dx/kernel/mrc/lib/CMakeFiles/conv.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : kernel/mrc/lib/CMakeFiles/conv.dir/depend
