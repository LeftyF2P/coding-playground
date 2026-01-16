extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var nav_agent: NavigationAgent2D = $Player/NavigationAgent2D
@onready var free_camera: Camera2D = $free_camera
@onready var lock_camera: Camera2D = $Player/lock_camera

@export var speed = 20
var click_position = Vector2()
var target_position
var moving = false

func _ready() -> void:
	#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	target_position = player.position

func _physics_process(delta):
	# Lock and center camera to player or unlock camera
	if Input.is_action_just_pressed("Camera_Center_Lock"):
		if lock_camera.enabled:
			free_camera.position = player.position
			free_camera.enabled = true
			lock_camera.enabled = false
		else:
			lock_camera.enabled = true
			free_camera.position = player.position
			free_camera.enabled = false
	
	# Player right clicked on the screen to move the character
	if Input.is_action_pressed("right_click"):
		click_position = get_global_mouse_position()
		if player.global_position.distance_to(click_position) > 5:
			nav_agent.target_position = click_position
			moving = true
	
	# If the click was farther away than a distance of 5 then move the player
	if moving:
		if nav_agent.is_navigation_finished():
			player.velocity = Vector2.ZERO
			moving = false
			return

		var next_position = nav_agent.get_next_path_position()
		var direction = (next_position - player.global_position).normalized()
		player.velocity = direction * speed
		player.move_and_slide()
		
		#var direction = (click_position - player.global_position).normalized()
		#player.velocity = direction * speed * delta
#
		#if player.global_position.distance_to(click_position) < 2:
			#player.global_position = click_position
			#player.velocity = Vector2.ZERO
			#moving = false

		#player.move_and_slide()
