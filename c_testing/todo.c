#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_TODO_LENGTH 256
#define MAX_TEXT 200
#define FILENAME "todo.txt"

typedef struct Task {
    char text[MAX_TODO_LENGTH];
    int completed;
} Task;
