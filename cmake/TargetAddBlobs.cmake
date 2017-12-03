
# target_add_blobs()
# ------------------
# Add binary linkable object to target.
# - `target` The target.
# - `...` The blob source file(s).
#
function(target_add_blobs target)
foreach(src_file ${ARGN})
	string(CONCAT blob_file "${src_file}" ".blob.o")
	add_custom_command(OUTPUT "${blob_file}"
		COMMAND ${CMAKE_LINKER} -r -b binary -o "${CMAKE_CURRENT_BINARY_DIR}/${blob_file}" "${src_file}"
		DEPENDS "${src_file}"
		WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
	)
	target_sources(${target} PRIVATE "${blob_file}")
endforeach()
endfunction()