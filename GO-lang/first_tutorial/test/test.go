package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
)

func main() {
	// 1. Open the file
	file, err := os.Open("first_tutorial/test.txt")
	if err != nil {
		log.Fatal(err)
	}
	// Ensure the file is closed once the function finishes
	defer file.Close()

	// 2. Create a new scanner
	scanner := bufio.NewScanner(file)

	// 3. Iterate over each line using a for loop
	for scanner.Scan() {
		line := scanner.Text() // Get the current line as a string
		fmt.Println(line)
	}

	// 4. Check for errors encountered during scanning
	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}
}
