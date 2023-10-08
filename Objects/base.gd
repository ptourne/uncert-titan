extends Node

class_name Base

signal energy_change(new_level)
signal oxigen_change(new_level)

const MAX_ENERGY = 100
const MAX_ENERGY_TRANSFER_SPEED = 7
var energy = 0

const MAX_OXIGEN = 100
const MAX_OXIGEN_TRANSFER_SPEED = 7
var oxigen = 0

func _ready():
	set_energy(0)
	set_oxigen(0)
	

func _process(delta):
	pass
	
func ask_energy(cuantity):
	var energy_to_give = min(cuantity, MAX_ENERGY_TRANSFER_SPEED)
	energy_to_give = min(energy_to_give, energy)
	set_energy(energy - energy_to_give)
	return energy_to_give

func ask_oxigen(cuantity):
	var oxigen_to_give = min(cuantity, MAX_OXIGEN_TRANSFER_SPEED)
	oxigen_to_give = min(oxigen_to_give, oxigen)
	set_oxigen(oxigen - oxigen_to_give)
	return oxigen_to_give

func recieve_energy(amount):
	set_energy(energy + min(MAX_ENERGY - energy, amount))

func set_energy(amount):
	energy = amount
	energy_change.emit(amount)

func set_oxigen(amount):
	print("Set oxigen:", amount)
	oxigen = amount
	oxigen_change.emit(amount)
