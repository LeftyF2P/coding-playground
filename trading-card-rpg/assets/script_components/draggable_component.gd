extends Node

@onready var card: Node2D = $".."

var draggable = false
var is_dragging = false
var initial_pos = null
var offset = null
var played = false

func _physics_process(delta: float) -> void:
	if draggable:
		# Get the offset of the mouse on the tower card
		if Input.is_action_just_pressed("click"):
			initial_pos = card.global_position
			offset = card.get_global_mouse_position() - card.global_position
			is_dragging = true
		
		# If the object is dragging then move with the mouse
		if is_dragging:
			card.global_position = card.get_global_mouse_position() - offset
		
		# When you release click, either attach to tower or snap back
		if Input.is_action_just_released("click"):
			is_dragging = false
			if true:
				card.global_position = card.get_global_mouse_position() - offset
			else:
				card.global_position = initial_pos


# When mouse is over the tower, apply effects
func _on_area_2d_mouse_entered() -> void:
	if !played:
		card.scale = card.scale * 1.05
		draggable = true
	else:
		draggable = false


# When mouse leaves tower, reverse any effects
func _on_area_2d_mouse_exited() -> void:
	if !played:
		card.scale = card.scale / 1.05
		draggable = false
