extends TileMap

class_name Map

enum layer_ids {
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
	print("Se intentó colocar en " + str(coor))
	# TODO: aca podemos poner la sombra
	self.place_tile(fallable.layer, fallable.tile_set, coor, fallable.coor)

func place_tile(layer: int, tile_set: int, coord: Vector2i, coord_tile: Vector2i):
	self.set_cell(layer, coord, tile_set, coord_tile, 0)
