extends Button
class_name SudokuCell


# Variables
@export var row: int = -1
@export var col: int = -1
var value: int = 0    # current value (0 empty)
var given: bool = false
var pencil_marks: Array = []  # list of ints as pencil marks


signal cell_selected(row, col)
signal value_changed(row, col, value)


func _ready():
	connect("pressed", _on_pressed)
	update_display()

func _on_pressed():
	emit_signal("cell_selected", row, col)

func set_given(val: int):
	value = val
	given = val != 0
	disabled = given
	update_display()

func set_value(val: int):
	if given: return
	value = val
	update_display()
	emit_signal("value_changed", row, col, value)

func clear_value():
	if given: return
	value = 0
	pencil_marks.clear()
	update_display()
	emit_signal("value_changed", row, col, value)

func toggle_pencil(mark: int):
	if given: return
	if mark in pencil_marks:
		pencil_marks.erase(mark)
	else:
		pencil_marks.append(mark)
		pencil_marks.sort()
	emit_signal("value_changed", row, col, value)
	update_display()

func update_display():
	# Basic textual display. You can style with Themes or RichTextLabel children.
	if value != 0:
		text = str(value)
	elif pencil_marks.size() > 0:
		# show small dot list
		text = "".join(pencil_marks)
		#text = "".join(str(x) for x in pencil_marks)
	else:
		text = ""
	# style given cells differently
	if given:
		add_theme_color_override("font_color", Color8(40,40,40))
	else:
		add_theme_color_override("font_color", Color8(20,80,120))
