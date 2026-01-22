#include <iostream>
#include "todo.h"

int main() {
    std::cout << "Hello World\n";
    int test;
    std::cin >> test;
    std::cout << "You entered " << test << std::endl;
    TodoList list;
    list.run();
    return 0;
}
