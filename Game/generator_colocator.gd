extends Node

@onready var base = $"../Base"
@onready var tile_map = $"../TileMap"
@onready var world = $".."

func place_windmill(location: Vector2i):
	if tile_map.place_windmill(location):
		var windmill = load("res://Objects/windmill_generator.tscn").instantiate()
		world.add_child(windmill)
		windmill.send_energy.connect(base.recieve_energy)

