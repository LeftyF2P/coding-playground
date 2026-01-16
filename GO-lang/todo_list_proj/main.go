package main

import (
	"fmt"
	"time"
)

type Task struct {
	ID			int
	Name		string
	Start		time.Time
	Deadline	time.Time
	Completed	bool
}

func main() {
	var tasks []Task
	
	AddTask(&tasks, "Clean my apartment")

	fmt.Println(tasks[0])
}

func AddTask(tasks *[]Task, name string, deadline_optional ...time.Time) {
	var deadline time.Time
	if len(deadline_optional) > 0 {
		deadline = deadline_optional[0]
	}

	task := Task{
		ID: 		len(*tasks) + 1,
		Name:		name,
		Start:		time.Now(),
		Deadline:	deadline,
		Completed:	false,
	}

	*tasks = append(*tasks, task)
}
