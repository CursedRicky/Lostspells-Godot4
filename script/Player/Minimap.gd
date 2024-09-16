extends Node2D

@onready var world = get_node("/root/Doungeon")
@export var tile_map : TileMap 
@onready var player = $"../../../../../../.."
@onready var map = $TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for cell in tile_map.get_used_cells(0):
		var tile = tile_map.get_cell_atlas_coords(0, cell)
		map.set_cell(0, cell, 0, tile)
