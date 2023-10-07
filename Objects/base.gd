extends Node

class_name Base

const MAX_ENERGY = 100
const MAX_ENERGY_TRANSFER_SPEED = 7
var energy = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	print("Base:", energy)

func ask_energy(cuantity):
	var energy_to_give = min(cuantity, MAX_ENERGY_TRANSFER_SPEED)
	energy_to_give = min(energy_to_give, energy)
	energy -= energy_to_give
	return energy_to_give
	
