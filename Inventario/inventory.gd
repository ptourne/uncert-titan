extends Node

@export var max_item: int

var inventory

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory = []
	inventory.resize(max_item)
	for i in range(inventory.count()):
		inventory[i] = null

func add_item(item: ItemId) -> bool: 
	for inventory_slot in inventory:
		if inventory_slot == null:
			continue
			
		if inventory_slot.could_append(item):
			return true
	
	for i in range(inventory.count()):
		if inventory[i] != null:
			continue
			
		inventory[i] = ItemId.get_item_from_id(item)
	
	return false

func remove_at(position: int) -> ItemId:
	var item_remove = inventory[position]
	
	if item_remove == null:
		return null
		
	if !item_remove.remove():
		return null
		
	if item_remove.is_empty():
		inventory[position] = null
		
	return item_remove.id
