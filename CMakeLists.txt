cmake_minimum_required(VERSION 3.0.2)

# Add local cmake module directory
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

option(EMBED_WITH_BLOB    "Embedded file(s) with binary linkable object" ON)
option(EMBED_WITH_INCLUDE "Embedded file(s) as c array with include"     OFF)

add_subdirectory(examples)