extends CharacterBody2D

@onready var game_manager = get_tree().current_scene.name

@export var speed = 100

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	get_input()
	velocity = velocity * delta
	move_and_slide()
	
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
