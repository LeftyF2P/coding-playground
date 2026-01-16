extends CharacterBody2D

@onready var game_manager: Node2D = $"../.."

const SPEED = 500.0
const JUMP_VELOCITY = -500.0
const COYOTE = 150

var is_dead = false
var last_on_floor = 0.0
var jumpable

func _physics_process(delta: float) -> void:
	# Check if dead first
	if is_dead:
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if Time.get_ticks_msec() - last_on_floor > COYOTE:
			jumpable = false
	else:
		last_on_floor = Time.get_ticks_msec()
		jumpable = true

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jumpable:
		velocity.y = JUMP_VELOCITY
		jumpable = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	# A debug setting to just kill Pete for testing
	if Input.is_action_just_pressed("ui_text_backspace"):
		death()
	


# Function to control everything that happens when Pete dies
func death():
	print("You have died")
	is_dead = true
	game_manager.spawn_pete()
	#position = game_manager.spawn.position
