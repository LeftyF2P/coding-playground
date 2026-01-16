package main

import (
	"fmt"
	"math/rand"
	"os"
	"strings"
)

const size = 9

var board [size][size]int

func main() {
	//rand.Seed(time.Now().UnixNano())

	if fillBoard(0, 0) {
		printBoard()
		saveBoardToFile("sudoku.csv")
		fmt.Println("Sudoku saved to sudoku.csv!")
	} else {
		fmt.Println("Failed to generate a board")
	}
}

func fillBoard(row, col int) bool {
	if row == size {
		return true // Board complete
	}

	// Move to next row if end of column
	nextRow, nextCol := row, col+1
	if nextCol == size {
		nextRow++
		nextCol = 0
	}

	// Try numbers 1-9 in random order
	nums := rand.Perm(9)
	for _, v := range nums {
		num := v + 1

		if isValid(row, col, num) {
			board[row][col] = num

			if fillBoard(nextRow, nextCol) {
				return true
			}
		}
		board[row][col] = 0 // backtrack
	}

	return false
}

func isValid(row, col, val int) bool {
	// Check if row is valid
	for i := range size {
		if board[row][i] == val {
			return false
		}
	}

	// Check if column is valid
	for j := range size {
		if board[j][col] == val {
			return false
		}
	}

	// Check if box is valid
	boxRow := row / 3 * 3
	boxCol := col / 3 * 3

	for i := boxRow; i < boxRow+3; i++ {
		for j := boxCol; j < boxCol+3; j++ {
			if val == board[i][j] {
				return false
			}
		}
	}

	return true
}

func printBoard() {
	for _, row := range board {
		count := 0
		for _, val := range row {
			count += 1
			if count < size {
				fmt.Printf("%d | ", val)
			} else {
				fmt.Printf("%d", val)
			}
		}
		fmt.Println()
	}
}

func saveBoardToFile(filename string) {
	var builder strings.Builder

	for i, row := range board {
		for j, val := range row {
			builder.WriteString(fmt.Sprintf("%d", val))
			if j < size-1 {
				builder.WriteString(",")
			}
		}
		if i < size-1 {
			builder.WriteString("\n")
		}
	}

	err := os.WriteFile(filename, []byte(builder.String()), 0644)
	if err != nil {
		fmt.Println("Error saving file: ", err)
	}
}
