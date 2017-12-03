# target_generate_includes()
# --------------------------
# Convert binary files to include able files for target, like xxx.inc
# - `...` Files to be generated.
# Examples:
#   generate_includes(aka.c aka.png)
# The new files will be generated:
#   ${CMAKE_CURRENT_BINARY_DIR}/aka.c.inc
#   ${CMAKE_CURRENT_BINARY_DIR}.aka.png.inc
#
function(target_generate_includes target)
	add_custom_target(${target}-embed-inc
		COMMENT "Generating embedded includes for ${target}"
	)
	foreach(src_file ${ARGN})
		string(CONCAT inc_file "${src_file}" ".inc")
		list(APPEND inc_files ${inc_file})
		list(APPEND env -DBINARY_DIR=${CMAKE_CURRENT_BINARY_DIR})
		list(APPEND env -DSOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR})
		list(APPEND env -DINC_FILE=${inc_file})
		list(APPEND env -DSRC_FILE=${src_file})
		add_custom_command(TARGET ${target}-embed-inc
			PRE_BUILD
			COMMAND ${CMAKE_COMMAND} ${env} -P ${CMAKE_SOURCE_DIR}/cmake/Bin2Inc.cmake
			DEPENDS ${src_file}
			WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
		)
	endforeach()
	add_dependencies(${target} ${target}-embed-inc)
	set_directory_properties(PROPERTIES
		ADDITIONAL_MAKE_CLEAN_FILES "${inc_files}"
	)
	target_include_directories(${target} PRIVATE ${CMAKE_CURRENT_BINARY_DIR})
endfunction()
