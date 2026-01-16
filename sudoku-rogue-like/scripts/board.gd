extends GridContainer
class_name BoardController


# Variables
@export var cell_scene: PackedScene
var cells := [] # 2D array of cell nodes
var puzzle := [] # current puzzle state (ints)
var solution := [] # solved board
var selected := Vector2i(-1,-1)
var pencil_mode := false


func _ready():
	columns = 9
	if cell_scene == null:
		cell_scene = preload("res://scenes/Cell.tscn")
	_build_empty_grid()
	#new_game("easy")

func _build_empty_grid():
	cells.clear()
	for r in range(0,9):
		var row_arr := []
		for c in range(0,9):
			var cell = cell_scene.instantiate()
			add_child(cell)
			cell.row = r
			cell.col = c
			cell.connect("cell_selected", _on_cell_selected)
			cell.connect("value_changed", _on_cell_value_changed)
			row_arr.append(cell)
		cells.append(row_arr)

func new_game(difficulty: String = "medium"):
	puzzle = Sudoku.generate_puzzle(difficulty)
	solution = Sudoku.clone_board(puzzle)
	Sudoku.solve(solution) # fills solution
	_load_puzzle_into_cells()

func _load_puzzle_into_cells():
	for r in range(0,9):
		for c in range(0,9):
			var val = puzzle[r][c]
			cells[r][c].set_given(val)
			# clear runtime value for non-given
			if not cells[r][c].given:
				cells[r][c].set_value(0)
			else:
				cells[r][c].value = val

func _on_cell_selected(r, c):
	selected = Vector2i(r, c)
	# optional: highlight selected row/col/box
	# Inform HUD
	#get_node_or_null("/root/Main")?.call_deferred("on_board_cell_selected", r, c)
	if get_node_or_null("/root/Main"):
		get_node_or_null("/root/Main").call_deferred("on_board_cell_selected", r, c)

func input_number(num: int):
	if selected.x < 0: return
	var cell = cells[selected.x][selected.y]
	if pencil_mode:
		cell.toggle_pencil(num)
	else:
		if cell.given:
			return
		# check correctness (optional auto-check)
		cell.set_value(num)
		puzzle[selected.x][selected.y] = num
		# you can check for completion:
		#_check_win()

func clear_selected():
	if selected.x < 0: return
	var cell = cells[selected.x][selected.y]
	cell.clear_value()
	puzzle[selected.x][selected.y] = 0

func _on_cell_value_changed(r, c, v):
	puzzle[r][c] = v
	# optional immediate validation feedback
	#if v != 0 and not Sudoku.valid(puzzle, r, c, v):
		## mark incorrect visually
		#cells[r][c].add_theme_color_override("font_color", Color.RED)
	#else:
		#cells[r][c].update_display()
	#_check_win()
	cells[r][c].update_display()

func _check_win():
	# Check if puzzle equals solution
	for r in range(0,9):
		for c in range(0,9):
			if puzzle[r][c] != solution[r][c]:
				return
	# Win!
	if get_node_or_null("/root/Main"):
		get_node_or_null("/root/Main").call_deferred("on_win")
