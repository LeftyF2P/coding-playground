extends CharacterBody2D

@export var rotation_speed = 1.0
@export var move_speed = 1.0

var player = null

func _physics_process(delta: float) -> void:
	if !player:
		#rotation += rotation_speed * delta
		pass
	else:
		velocity = global_position.direction_to(player.global_position) * move_speed * delta
		move_and_slide()

func _on_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if body.name == "Player":
		player = body

func _on_body_shape_exited(_body_rid: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	player = null
