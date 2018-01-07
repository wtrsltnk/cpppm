cmake_minimum_required(VERSION 3.7)

project(test-project)

list(APPEND CMAKE_PREFIX_PATH "$ENV{userprofile}/.cpppm/install")

list(APPEND CMAKE_MODULE_PATH ${CMAKE_PREFIX_PATH}/cmake)

find_package(SDL2 REQUIRED)
find_package(BULLET REQUIRED)
find_package(OPENGL REQUIRED)

add_executable(test-exe
    program.cpp
    )

target_include_directories(test-exe
    PRIVATE ${BULLET_INCLUDE_DIR}
    )

target_link_libraries(test-exe
    SDL2::SDL2-static
    ${OPENGL_LIBRARIES}
    ${BULLET_LIBRARIES}
    )
