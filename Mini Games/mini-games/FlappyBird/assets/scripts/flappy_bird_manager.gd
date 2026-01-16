extends Node2D

@onready var flappy_bird_player: CharacterBody2D = $FlappyBirdPlayer
@onready var pipe_list: Node2D = $PipeList
@onready var pipe_spawn_point: Node2D = $PipeSpawnPoint
const PIPE = preload("uid://8ndhqcnrhmrv")


var spawn_timer = 0
@export var spawn_rate = .5


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var current_frame = Engine.get_physics_frames()
	if (current_frame - spawn_timer) / 60.0 > spawn_rate:
		spawn_pipe()
		spawn_timer = current_frame


func spawn_pipe():
	var rand_pipe_height = randi_range(-400, 400)

	var top_pipe = PIPE.instantiate()
	pipe_list.add_child(top_pipe)
	top_pipe.position = pipe_spawn_point.position
	top_pipe.position.y += -400 + rand_pipe_height
	top_pipe.scale.y = 4

	var bottom_pipe = PIPE.instantiate()
	pipe_list.add_child(bottom_pipe)
	bottom_pipe.position = pipe_spawn_point.position
	bottom_pipe.position.y += 400 + rand_pipe_height
	bottom_pipe.scale.y = 4

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Restart"):
		spawn_timer = Engine.get_physics_frames()
		for pipe in pipe_list.get_children():
			pipe.queue_free()

		flappy_bird_player.dead = false
		flappy_bird_player.position.y = 540
		flappy_bird_player.velocity = Vector2.ZERO
