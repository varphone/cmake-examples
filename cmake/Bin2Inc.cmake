#!/usr/bin/cmake -P

if(EXISTS "${BINARY_DIR}/${INC_FILE}" AND "${BINARY_DIR}/${INC_FILE}" IS_NEWER_THAN "${SOURCE_DIR}/${SRC_FILE}")
message(STATUS "Generated ${INC_FILE} is newer than ${SRC_FILE}, ignored.")
else()
message(STATUS "Generating ${INC_FILE} ... ")
if(WIN32)
message(WARNING "FIXME: Windows platform not supported yet.")
else()
execute_process(
	COMMAND xxd -i ${SRC_FILE}
	RESULT_VARIABLE aka
	ERROR_VARIABLE ake
	WORKING_DIRECTORY ${SOURCE_DIR}
	OUTPUT_FILE ${BINARY_DIR}/${INC_FILE}
)
endif(WIN32)
endif()
