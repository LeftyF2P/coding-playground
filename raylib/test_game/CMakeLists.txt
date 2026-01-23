cmake_minimum_required(VERSION 3.20)
project(test_game LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(FetchContent)

FetchContent_Declare(
  raylib
  GIT_REPOSITORY https://github.com/raysan5/raylib.git
  GIT_TAG 5.0
)

set(BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(raylib)

add_executable(test_game source/main.cpp)
target_link_libraries(test_game PRIVATE raylib)

add_custom_target(run
    COMMAND test_game
    DEPENDS test_game
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
)
