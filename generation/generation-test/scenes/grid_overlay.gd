extends Node2D

@export var grid_spacing = 10.0
@export var major_line_dist = 5
@export var minor_color = Color(1.0, 1.0, 1.0, .15)
@export var major_color = Color(0.0, 0.0, 0.0, 0.557)
@export var major_line_width = 1.5
@export var minor_line_width = 1.0
@export var grid_padding = 100.0

@onready var camera_2d: Camera2D = $"../Camera2D"

func _draw():
	var viewport_rect = get_viewport_rect()
	var camera_rect = camera_2d.get_canvas_transform().affine_inverse()
	
	var top_left = camera_rect * Vector2.ZERO
	var bottom_right = camera_rect * viewport_rect.size
	
	draw_line(
		Vector2(top_left.x, (top_left.y + bottom_right.y)/2),
		Vector2(bottom_right.x, (top_left.y + bottom_right.y)/2),
		major_color,
		major_line_width * camera_rect.x.x
	)
