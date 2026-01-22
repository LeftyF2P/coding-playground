cmake_minimum_required(VERSION 3.16)

project(cpp_todo LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_executable(cpp_todo
    src/main.cpp
    src/todo.cpp
)
