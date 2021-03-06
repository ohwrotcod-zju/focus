file(READ ${INFILE} FILE_STRING)
message(STATUS "FILE_STRING=${FILE_STRING}")
string(REGEX REPLACE ";" "\\\\;" FILE_LIST "${FILE_STRING}")
string(REGEX REPLACE "\n" ";" FILE_LIST  "${FILE_LIST}")
foreach(CFILE ${FILE_LIST})
	message(STATUS "compiling "${CFILE})
	execute_process(COMMAND gcc -c -DPROTOTYPE -Dalliant -w -ffast-math ${CFILE})
endforeach(CFILE)
