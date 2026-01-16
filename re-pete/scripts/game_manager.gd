extends Node2D

const PETE_PREFAB = preload("res://assets/characters/pete.tscn")

@onready var pete: CharacterBody2D = $"Test World/Pete"
@onready var test_world: Node2D = $"Test World"

var level : Node2D
var spawn : Node2D

var pete_count = 0

func _ready():
	level = test_world
	load_level(0)

# Load the next level into the game
func load_level(level: int) -> void:
	spawn = get_spawn_point()
	pete.position = spawn.position

# Get the spawn point of the current loaded level
func get_spawn_point():
	return level.get_node("SpawnPoint")

# Spawns in a new movable Pete
func spawn_pete():
	pete_count += 1
	print("Pete Count: " + str(pete_count))
	var new_pete = PETE_PREFAB.instantiate()
	level.add_child(new_pete)
	pete = new_pete
	load_level(0)
