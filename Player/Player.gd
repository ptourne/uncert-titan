class_name Player

extends CharacterBody2D

signal die(message)

@onready var tile_map: Map = $".."

@export var game_manager : GameManager
@export var base: Base
@export var inventory: Inventory

const WALKING_ACCELERATION = 600
const RUNNIN_ACCELERATION = 1000
const MAX_WALKING_SPEED = 80
const MAX_RUNNIN_SPEED = 150
const MAX_SPEED = 150
const WALKING_FRICTION = 800
const RUNNIN_FRICTION = 1200
const MAX_OXIGEN_LEVEL = 100
const MAX_OXIGEN_TRANSFER_SPEED = 5
const MAX_ENERGY_LEVEL = 100
const MAX_ENERGY_TRANSFER_SPEED = 5

const OX_COST_PER_VELOCITY = 0.1
const OX_COST_BASE = 0.01

var running = false
var oxigen : int = MAX_OXIGEN_LEVEL
var energy : int = 0
var is_on_space_suit = false
var in_base = false

func _process(delta):
	pass
	
func is_running():
	return running

func max_speed():
	if self.is_running():
		return MAX_RUNNIN_SPEED
	else:
		return MAX_WALKING_SPEED

func acceleration():
	if self.is_running():
		return RUNNIN_ACCELERATION
	else:
		return WALKING_ACCELERATION
		
func friction():
	if self.is_running():
		return RUNNIN_FRICTION
	else:
		return WALKING_FRICTION

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * self.max_speed(), self.acceleration() * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, self.friction() * delta)
		
	move_and_slide()


func _input(event):
	if event.is_action_pressed("ui_run"):
		running = true

	if event.is_action_released("ui_run"):
		running = false

func _pick_up_item(body_rid, body: TileMap, body_shape_index, local_shape_index):
	var position = body.get_coords_for_body_rid(body_rid)
	var item_id = self.tile_map.remove_item(position)
	
	if item_id >= 0:
		self.inventory.add_item(item_id)

func _on_tile_detector_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	_handle_under_roof(body_rid, body)
	
func _handle_under_roof(body_rid, current_tile_map):
#	var roof_tile_coords = current_tile_map.get_coords_for_body_rid(body_rid)
	current_tile_map.hide_roof()
	in_base = true

func _on_tile_detector_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	_handle_off_roof(body_rid, body)
	
func _handle_off_roof(body_rid, current_tile_map):
	current_tile_map.show_roof()
	in_base = false

func oxigen_toll():
	return velocity.length() * OX_COST_PER_VELOCITY + OX_COST_BASE
	
func decrease_oxigen_level():
	oxigen -= oxigen_toll()

func _on_breading_timer_timeout():
	decrease_oxigen_level()
	if oxigen <= 0:
		die.emit("Asfixiation")

func _on_charging_timer_timeout():
	if in_base:
		var energy_to_ask = min(MAX_ENERGY_LEVEL - energy, MAX_ENERGY_TRANSFER_SPEED)
		energy += base.ask_energy(energy_to_ask)

func _on_oxigen_charging_timer_timeout():
	if in_base:
		var oxigen_to_ask = min(MAX_OXIGEN_LEVEL - oxigen, MAX_OXIGEN_TRANSFER_SPEED)
		oxigen += base.ask_oxigen(oxigen_to_ask)
