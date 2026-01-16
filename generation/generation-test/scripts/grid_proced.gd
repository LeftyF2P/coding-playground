extends Node2D

@export var grid_size = 64
@export var major_line_dist = 5
@export var minor_color = Color(1.0, 1.0, 1.0, .15)
@export var major_color = Color(0.0, 0.0, 0.0, 0.557)
@export var major_line_width = 1.5
@export var minor_line_width = 1.0

@onready var camera: Camera2D = $Camera2D

func _draw():
	var viewport_rect = get_viewport_rect()
	var cam_pos = camera.global_position

	var start_x = floor((cam_pos.x - viewport_rect.size.x) / grid_size) * grid_size
	var end_x   = ceil((cam_pos.x + viewport_rect.size.x) / grid_size) * grid_size

	var start_y = floor((cam_pos.y - viewport_rect.size.y) / grid_size) * grid_size
	var end_y   = ceil((cam_pos.y + viewport_rect.size.y) / grid_size) * grid_size

	for x in range(start_x, end_x + 1, grid_size):
		@warning_ignore("integer_division")
		var is_major = int(x / grid_size) % major_line_dist == 0
		draw_line(
			Vector2(x, start_y),
			Vector2(x, end_y),
			major_color if is_major else minor_color,
			major_line_width
		)

	for y in range(start_y, end_y + 1, grid_size):
		@warning_ignore("integer_division")
		var is_major = int(y / grid_size) % major_line_dist == 0
		draw_line(
			Vector2(start_x, y),
			Vector2(end_x, y),
			major_color if is_major else minor_color,
			minor_line_width
		)

func _process(_delta):
	queue_redraw()
