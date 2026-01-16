extends Node2D

var move_speed = 200

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= move_speed * delta



func _on_pipe_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("FlappyBird"):
		body.dead = true
