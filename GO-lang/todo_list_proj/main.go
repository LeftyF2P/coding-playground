package main

import (
	"fmt"
)

func main() {
	var taskItems []string

	taskItems = append(taskItems, "Have fun")
	taskItems = addTask(taskItems, "Go to work")
	fmt.Println(taskItems[2])
}

func addTask(taskArr []string, newTask string) []string {
	taskArr = append(taskArr, newTask)
	return taskArr
}
