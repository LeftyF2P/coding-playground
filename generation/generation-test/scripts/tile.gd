extends Sprite2D

var tile_type
var tile_list

var grid_pos
var constraints

var neighbors = {
	"UP": null,
	"DOWN": null,
	"LEFT": null,
	"RIGHT": null
}

enum TILE_TYPE{
	GRASS,
	WATER,
	SAND,
	STONE
}

const CONNECTION_ALLOWED = {
	TILE_TYPE.GRASS: [TILE_TYPE.GRASS, TILE_TYPE.SAND, TILE_TYPE.STONE],
	TILE_TYPE.WATER: [TILE_TYPE.WATER, TILE_TYPE.SAND],
	TILE_TYPE.SAND: [TILE_TYPE.GRASS, TILE_TYPE.WATER, TILE_TYPE.SAND],
	TILE_TYPE.STONE: [TILE_TYPE.GRASS, TILE_TYPE.STONE]
}

const COLORS = {
	TILE_TYPE.GRASS: Color(0.0, 1.0, 0.0, 1.0),
	TILE_TYPE.WATER: Color(0.0, 0.0, 1.0, 1.0),
	TILE_TYPE.SAND: Color(0.713, 0.0, 0.0, 1.0),
	TILE_TYPE.STONE: Color(0.363, 0.363, 0.363, 1.0)
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tile_list = [TILE_TYPE.GRASS, TILE_TYPE.WATER, TILE_TYPE.SAND, TILE_TYPE.STONE]
	constraints = tile_list

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func set_list(neighbor_type):
	tile_list = tile_list.filter(func(t):
		return CONNECTION_ALLOWED[neighbor_type].has(t)
	)

func set_type():
	tile_type = tile_list[randi_range(0, len(tile_list) - 1)]
	modulate = COLORS[tile_type]
