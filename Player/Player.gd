class_name Player

extends CharacterBody2D

signal die(message)
signal energy_change(new_level)
signal oxigen_change(new_level)

@onready var tile_map: Map = $".."
@onready var graphics = $Graphics

@export var game_manager : GameManager
@export var base: Base
@export var inventory: Inventory
@export var send_message: SendMessage
@export var send_despcription: Descriptable

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

const OX_COST_PER_VELOCITY = 0.01
const OX_COST_BASE = 0.005

var running = false
var oxigen : int = MAX_OXIGEN_LEVEL
var energy : int = MAX_ENERGY_LEVEL
var is_on_space_suit = false
var in_base = false
var facing_direction = [1,1]
var step = 0

func _ready():
	set_energy(MAX_ENERGY_LEVEL)
	set_oxigen(MAX_OXIGEN_LEVEL)
	
func _process(delta):
	if velocity.y > 0:
		set_vertical_facing_direction_down()
	if velocity.y < 0:
		set_vertical_facing_direction_up()
	if velocity.x > 0:
		set_horizontal_facing_direction_right()
	if velocity.x < 0:
		set_horizontal_facing_direction_left()

func update_facing_direction():
	graphics.frame = 2*facing_direction[0] + 4*facing_direction[1] + step
	
func set_vertical_facing_direction_up():
	facing_direction[1] = 1
	update_facing_direction()
	
func set_vertical_facing_direction_down():
	facing_direction[1] = 0
	update_facing_direction()
	
func set_horizontal_facing_direction_right():
	facing_direction[0] = 0
	update_facing_direction()
	
func set_horizontal_facing_direction_left():
	facing_direction[0] = 1
	update_facing_direction()
	
func is_running():
	set_vertical_facing_direction_down()
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
	
	if event.is_action_pressed("SendText"):
		self.send_message.send_message("Hola tanto tiempo")

func _pick_up_item(body_rid, body: TileMap, body_shape_index, local_shape_index):
	var position = body.get_coords_for_body_rid(body_rid)
	var item_id = self.tile_map.remove_item(position)
	
	if item_id >= 0:
		self.inventory.add_item(item_id)

func _interact_descriptable(body_rid, body: TileMap, body_shape_index, local_shape_index):
	var position = body.get_coords_for_body_rid(body_rid)
	var description = self.tile_map.get_description(position)
	if description != "":
		self.send_despcription.emit_description(description)

func _hide_descriptable(body_rid, body: TileMap, body_shape_index, local_shape_index):
	var position = body.get_coords_for_body_rid(body_rid)
	var description = self.tile_map.get_description(position)
	if description != "":
		self.send_despcription.emit_hide()

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
	set_oxigen(oxigen - oxigen_toll())

func _on_breading_timer_timeout():
	decrease_oxigen_level()
	if oxigen <= 0:
		die.emit("Asfixiation")

func _on_charging_timer_timeout():
	if in_base:
		var energy_to_ask = min(MAX_ENERGY_LEVEL - energy, MAX_ENERGY_TRANSFER_SPEED)
		set_energy(energy + base.ask_energy(energy_to_ask))

func _on_oxigen_charging_timer_timeout():
	if in_base:
		var oxigen_to_ask = min(MAX_OXIGEN_LEVEL - oxigen, MAX_OXIGEN_TRANSFER_SPEED)
		set_oxigen(oxigen + base.ask_oxigen(oxigen_to_ask))


func set_energy(amount):
	energy = amount
	energy_change.emit(amount)

func set_oxigen(amount):
	oxigen = amount
	oxigen_change.emit(amount)


func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	pass # Replace with function body.


func _step():
	if velocity.length() >= 0.1:
		make_step()

func make_step():
	if step == 1:
		step = 0
	else:
		step = 1
	update_facing_direction()
