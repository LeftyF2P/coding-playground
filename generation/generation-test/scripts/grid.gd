extends Node2D

const TILE = preload("uid://db7a88bvp04rf")

@export var grid_width = 100
@export var grid_height = 100

var grid_start = Vector2(0, 0)
var grid = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(grid_width):
		grid.append([])
		for j in range(grid_height):
			var new_tile = TILE.instantiate()
			add_child(new_tile)
			
			new_tile.grid_pos = Vector2(i, j)
			var tile_size = new_tile.texture.get_size()
			var tile_x_pos = new_tile.position.x + (tile_size.x / 2) + (i * tile_size.x)
			var tile_y_pos = new_tile.position.y + (tile_size.y / 2) + (j * tile_size.y)
			new_tile.position = Vector2(tile_x_pos, tile_y_pos)
			
			grid[i].append(new_tile)
	
	assign_neighbors()
	for row in grid:
		for tile in row:
			update_tile()

func assign_neighbors():
	for i in range(grid_width):
		for j in range(grid_height):
			var tile = grid[i][j]
			if j > 0:
				tile.neighbors.UP = grid[i][j-1]
			if j < grid_height - 1:
				tile.neighbors.DOWN = grid[i][j+1]
			if i > 0:
				tile.neighbors.LEFT = grid[i-1][j]
			if i < grid_width - 1:
				tile.neighbors.RIGHT = grid[i+1][j]

func update_tile():
	var tile
	for i in range(grid_width):
		for j in range(grid_height):
			var new_tile = grid[i][j]
			@warning_ignore("unassigned_variable")
			if tile == null and new_tile.tile_type == null:
				tile = new_tile
			elif new_tile.tile_type == null and len(tile.tile_list) > len(new_tile.tile_list):
				tile = new_tile
	
	tile.set_type()
	
	for neighbor in tile.neighbors.values():
		if neighbor != null:
			neighbor.set_list(tile.tile_type)
