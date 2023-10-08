extends TileMap

class_name Map

func _ready():
	pass 

var body_count = 0

func hide_roof():
	if body_count == 0:
		set_layer_modulate(LayerId.roof, Color(1, 1, 1, 0))
	body_count += 1
	
func show_roof():
	body_count -= 1
	if body_count == 0:
		set_layer_modulate(LayerId.roof, Color(1,1,1,1))

func hanldle_new_position(coor: Vector2i, fallable: Fallable):
	# TODO: aca podemos poner la sombra
	self.place_tile(fallable.layer, fallable.tile_set, coor, fallable.coor)

func place_tile(layer: int, tile_set: int, coord: Vector2i, coord_tile: Vector2i):
	self.set_cell(layer, coord, tile_set, coord_tile, 0)

func place_windmill(coords: Vector2i) -> bool:
	if get_cell_tile_data(LayerId.walls, coords):
		return false
	set_cell(LayerId.walls, coords, 6, Vector2i.ZERO, 0)
	return true

func remove_item(coords: Vector2i) -> int:
	var tile_data = get_cell_tile_data(LayerId.item, coords)
	if !tile_data:
		return -1
	
	erase_cell(LayerId.item, coords)
	return tile_data.get_custom_data("item_id")

func get_description(coords: Vector2i) -> String:
	var tile_data = get_cell_tile_data(LayerId.descritable, coords)
	if !tile_data:
		return ""
	return tile_data.get_custom_data("description")
