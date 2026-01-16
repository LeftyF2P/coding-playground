extends Node


# Basic representation: 9x9 2D Array of ints (0 = empty)
const SIZE := 9
const BOX := 3


# Solve with backtracking; also supports counting solutions up to a limit.
# board is a mutable array of arrays; we clone internally when needed.


# Clones sudoku board and returns the cloned board
func clone_board(board: Array) -> Array:
	var b := []
	for row in board:
		b.append(row.duplicate())
	return b

# Returns all empty cells as a dictionary
func find_empty(board: Array) -> Array:
	for row in SIZE:
		for col in SIZE:
			if board[row][col] == 0:
				return [row, col]
	return []

## Check if the cell is valid
func valid(board: Array, r: int, c: int, val: int) -> bool:
	# row
	for i in range(SIZE):
		if i != c:
			if board[r][i] == val:
				return false
	# col
	for j in SIZE:
		if r != j:
			if board[j][c] == val:
				return false
	
	# Check the Box
	@warning_ignore("integer_division")
	var br = (r/3) * 3
	@warning_ignore("integer_division")
	var bc = (c/3) * 3
	
	for i in range(br, br+3):
		for j in range(bc, bc+3):
			if i != c and j != r:
				if val == board[i][j]:
					return false
	
	return true

# Standard backtracking solver that returns true if solved and modifies board in place
func solve(board: Array) -> bool:
	var found := false
	var r = -1
	var c = -1
	
	# Loop through every cell, if all are filled in then return solved
	for i in SIZE:
		for j in SIZE:
			if board[i][j] == 0:
				r = i; c = j; found = true; break
		if found: break
	if not found:
		return true  # solved
	
	# If not solved then place in numbers to try and solve the board
	for val in range(1, SIZE+1):
		if valid(board, r, c, val):
			board[r][c] = val
			if solve(board):
				return true
			board[r][c] = 0
	
	# If no solution can be found return false
	return false


# Count solutions up to limit (to check uniqueness)
func count_solutions(board: Array, limit: int = 2) -> int:
	# returns 0,1,2 (2 meaning "2 or more")
	var b = clone_board(board)
	return _count_solutions_recursive(b, limit)

func _count_solutions_recursive(board: Array, limit: int) -> int:
	# find empty
	var found = false
	var r = -1; var c = -1
	for i in SIZE:
		for j in SIZE:
			if board[i][j] == 0:
				r = i; c = j; found = true; break
		if found: break
	if not found:
		return 1
	var total = 0
	for val in range(1, SIZE+1):
		if valid(board, r, c, val):
			board[r][c] = val
			total += _count_solutions_recursive(board, limit)
			board[r][c] = 0
			if total >= limit:
				return total
	return total


# Generator: fill board then remove cells while keeping uniqueness.
func generate_full_board() -> Array:
	# Start with empty and randomized fill order
	var board = []
	for i in SIZE:
		board.append([0,0,0,0,0,0,0,0,0])
	_fill_board_random(board)
	return board

func _fill_board_random(board: Array) -> bool:
	
	var first_zero = find_empty(board)
	if first_zero.is_empty():
		return true
	
	for r in range(first_zero[0], SIZE):
		
		# Get a random list of vals 1-9
		var vals = []
		for val in range(1, SIZE+1):
			vals.append(val)
		vals.shuffle()
		
		for c in range(first_zero[1], SIZE):
			while board[r][c] == 0:
				if valid(board, r, c, vals[0]) and len(vals) > 1:
					board[r][c] = vals.pop_front()
					_fill_board_random(board)
				elif len(vals) > 1:
					vals.pop_front()
				else:
					if c > 0:
						board[r][c-1] = 0
					else:
						board[r-1][8] = 0
					return false
	
	return true



# Make puzzle by removing cells while ensuring unique solution.
# difficulty: "easy", "medium", "hard" -> number of clues to leave
func generate_puzzle(difficulty: String = "medium") -> Array:
	var full = generate_full_board()
	var clues := 36  # default medium
	match difficulty:
		"easy":
			clues = 40
		"medium":
			clues = 36
		"hard":
			clues = 28
		"expert":
			clues = 22
	# positions list
	var positions := []
	for i in SIZE:
		for j in SIZE:
			positions.append(Vector2i(i,j))
	positions.shuffle()
	var to_remove = SIZE*SIZE - clues
	for pos in positions:
		if to_remove <= 0:
			break
		var r = pos.x
		var c = pos.y
		var backup = full[r][c]
		full[r][c] = 0
		# check uniqueness
		var clone = clone_board(full)
		var n = count_solutions(clone, 2)
		if n != 1:
			# can't remove, restore
			full[r][c] = backup
		else:
			to_remove -= 1
	return full
