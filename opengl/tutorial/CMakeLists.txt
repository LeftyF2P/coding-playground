cmake_minimum_required(VERSION 3.20)
project(gl_tutorial LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Export compile_commands.json for clangd (Neovim LSP).
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# ----- OpenGL and GLFW -----
find_package(OpenGL REQUIRED)
find_package(glfw3 REQUIRED)

# ----- GLAD -----
add_library(glad STATIC
    external/glad/src/glad.c
)
target_include_directories(glad PUBLIC
    external/glad/include
)

add_executable(gl_tutorial
    src/main.cpp
    src/gl/Shader.cpp
    src/gl/VBO.cpp
    src/gl/VAO.cpp
    src/gl/EBO.cpp
)

target_link_libraries(gl_tutorial PRIVATE
    glad
    glfw
    OpenGL::GL
    ${CMAKE_DL_LIBS}
)

# Include directories
target_include_directories(gl_tutorial PRIVATE
    ${CMAKE_SOURCE_DIR}/src
    ${CMAKE_SOURCE_DIR}/src/gl
)

# Copy shaders to build directory
file(COPY ${CMAKE_SOURCE_DIR}/shaders
     DESTINATION ${CMAKE_BINARY_DIR})

# Some toolchains require this to get dlopen/dlsym; harmless if not needed.
target_link_libraries(gl_tutorial PRIVATE dl)
