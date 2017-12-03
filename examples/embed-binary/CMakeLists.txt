project(embed-binary)

include(TargetAddBlobs)
include(TargetGenerateIncludes)

set(SOURCES
	demo.c
)
set(BLOBS
	demo.c
	demo.png
)

add_executable(${PROJECT_NAME} ${SOURCES})

if(EMBED_WITH_BLOB)
	target_compile_definitions(${PROJECT_NAME} PRIVATE -DEMBED_WITH_BLOB=1)
	target_add_blobs(${PROJECT_NAME} ${BLOBS})
endif()

if(EMBED_WITH_INCLUDE)
	target_compile_definitions(${PROJECT_NAME} PRIVATE -DEMBED_WITH_INCLUDE=1)
	target_generate_includes(${PROJECT_NAME} ${BLOBS})
endif()