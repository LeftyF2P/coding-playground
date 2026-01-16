cmake_minimum_required(VERSION 3.20)
project(opengl_hello LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# GLAD as a small C library
add_library(glad STATIC
    external/glad/src/glad.c
)
target_include_directories(glad PUBLIC
    external/glad/include
)

# GLFW from system packages (Fedora)
find_package(PkgConfig REQUIRED)
pkg_check_modules(GLFW REQUIRED glfw3)

add_executable(opengl_hello
    src/main.cpp
)

target_include_directories(opengl_hello PRIVATE
    ${GLFW_INCLUDE_DIRS}
    external/glad/include
)

target_link_libraries(opengl_hello PRIVATE
    glad
    ${GLFW_LIBRARIES}
)

# Needed on Linux for OpenGL + X11
find_package(OpenGL REQUIRED)
target_link_libraries(opengl_hello PRIVATE OpenGL::GL)

# Some distros need extra link flags from pkg-config
target_link_options(opengl_hello PRIVATE ${GLFW_LDFLAGS})
