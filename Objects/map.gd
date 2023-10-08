extends TileMap

class_name Map

enum layer_ids {
	walls = 4,
	roof = 5
}

func _ready():
	pass 

var body_count = 0

func hide_roof():
	if body_count == 0:
		set_layer_modulate(layer_ids.roof, Color(1, 1, 1, 0))
	body_count += 1
	
func show_roof():
	body_count -= 1
	if body_count == 0:
		set_layer_modulate(layer_ids.roof, Color(1,1,1,1))

func hanldle_new_position(coor: Vector2i, fallable: Fallable):
	# TODO: aca podemos poner la sombra
	self.place_tile(fallable.layer, fallable.tile_set, coor, fallable.coor)

func place_tile(layer: int, tile_set: int, coord: Vector2i, coord_tile: Vector2i):
	self.set_cell(layer, coord, tile_set, coord_tile, 0)

func place_windmill(coords: Vector2i) -> bool:
	if get_cell_tile_data(layer_ids.walls, coords):
		return false
	set_cells_terrain_connect(layer_ids.walls, [coords], 1, 0)
	return true
