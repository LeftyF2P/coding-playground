extends Camera2D

@export var move_speed = 750.0
@export var zoom_speed = 5.0
@onready var grid: Node2D = $"../grid"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("zoom_in"):
		zoom.x += zoom_speed * delta
		zoom.y += zoom_speed * delta
	if Input.is_action_just_pressed("zoom_out"):
		if zoom.x - zoom_speed * delta > 0:
			zoom.x -= zoom_speed * delta
			zoom.y -= zoom_speed * delta
	
	if Input.is_action_pressed("move_left"):
		position.x -= move_speed * delta
	if Input.is_action_pressed("move_right"):
		position.x += move_speed * delta
	if Input.is_action_pressed("move_up"):
		position.y -= move_speed * delta
	if Input.is_action_pressed("move_down"):
		position.y += move_speed * delta
	
	grid.queue_redraw()
