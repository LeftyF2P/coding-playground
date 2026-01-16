extends Control


func _ready():
	pass
	# start a default game:
	#	$Board.new_game("medium")

func on_board_cell_selected(r, c):
	# could update a "selected cell" display on HUD
	pass

func on_win():
	$"Win Screen".popup_centered()
	$HUD.timer_running = false

#func _unhandled_input(ev):
	#if ev is InputEventKey and ev.pressed and not ev.echo:
		#var num = -1
		#match ev.scancode:
			#KEY_1, KEY_KP_1: num = 1
			#KEY_2, KEY_KP_2: num = 2
			#KEY_3, KEY_KP_3: num = 3
			#KEY_4, KEY_KP_4: num = 4
			#KEY_5, KEY_KP_5: num = 5
			#KEY_6, KEY_KP_6: num = 6
			#KEY_7, KEY_KP_7: num = 7
			#KEY_8, KEY_KP_8: num = 8
			#KEY_9, KEY_KP_9: num = 9
			#KEY_BACKSPACE, KEY_DELETE: $Board.clear_selected(); return
		#if num > 0:
			#$Board.input_number(num)
