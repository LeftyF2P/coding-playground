extends Control
class_name HUDController

#Variables
@onready var board = get_node("../Board") # or adjust path
@onready var timer_label = $Time
var timer_seconds = 0
var timer_running = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# connect keypad buttons to `_on_keypad_pressed`
	for i in range(1,10):
		var btn = $Numbers.get_node(str(i))
		btn.pressed.connect(_on_keypad_pressed.bind(i))
	$Clear.pressed.connect(_on_clear_pressed)
	$Pencil.pressed.connect(_on_pencil_toggled)
	$"New Game".pressed.connect(_on_new_game.bind($Difficulty.selected))
	$Hint.pressed.connect(_on_hint_pressed)

func _process(delta):
	if timer_running:
		timer_seconds += delta
		timer_label.text = _format_time(timer_seconds)

func _format_time(t):
	var s = int(t) % 60
	var m = int(t) / 60
	return str(m) + ":" + str(s)

func _on_keypad_pressed(num):
	print("Number " + str(num) + " pressed")
	board.input_number(num)

func _on_clear_pressed():
	print("Clear")
	board.clear_selected()

func _on_pencil_toggled():
	print("Pencil")
	board.pencil_mode = !board.pencil_mode

func _on_new_game(difficulty):
	print("New Game on " + str(difficulty) + " difficulty")
	board.new_game("easy")
	timer_seconds = 0
	timer_running = true

func _on_hint_pressed():
	print("hint")
	# Simple hint: fill a single empty cell with correct solution
	# find first empty cell
	#for r in range(0,9):
		#for c in range(0,9):
			#if board.puzzle[r][c] == 0:
				#var val = board.solution[r][c]
				#board.cells[r][c].set_value(val)
				#board.puzzle[r][c] = val
				#return
