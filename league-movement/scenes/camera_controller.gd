extends Camera2D

@export var min_zoom = 2
@export var max_zoom = 5
@export var temp_camera_lock = false
@export var true_camera_lock = false

@onready var player: CharacterBody2D = $"../Player"


func _ready() -> void:
	zoom.x = (min_zoom + max_zoom) / 2
	zoom.y = (min_zoom + max_zoom) / 2

func _physics_process(_delta: float) -> void:
	# If the camera is locked to the player then move camera to player
	if true_camera_lock: 
		position = player.position
	
	# Lock and center camera to player or unlock camera
	if Input.is_action_just_pressed("Camera_Center_Lock"):
		if true_camera_lock:
			true_camera_lock = false
		else:
			true_camera_lock = true
			position = player.position
	
	# Manually snap camera to player while it is being held down
	if Input.is_action_pressed("Camera_Center"):
		position = player.position
		temp_camera_lock = true
	if Input.is_action_just_released("Camera_Center"):
		temp_camera_lock = false
	
	# Move the camera left and right
	if Input.is_action_pressed("Camera_Up") and !temp_camera_lock and !true_camera_lock:
		position.y -= 4
	if Input.is_action_pressed("Camera_Down") and !temp_camera_lock and !true_camera_lock:
		position.y += 4
	if Input.is_action_pressed("Camera_Left") and !temp_camera_lock and !true_camera_lock:
		position.x -= 4
	if Input.is_action_pressed("Camera_Right") and !temp_camera_lock and !true_camera_lock:
		position.x += 4

	# Zoom the camera in and out
	if Input.is_action_just_pressed("Camera_Zoom_In"):
		if zoom.x < max_zoom and zoom.y < max_zoom:
			zoom.x += .1
			zoom.y += .1
	if Input.is_action_just_pressed("Camera_Zoom_Out"):
		if zoom.x > min_zoom and zoom.y > min_zoom:
			zoom.x -= .1
			zoom.y -= .1
