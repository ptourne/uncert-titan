extends Node

@export var deploy_manager: DeployManager
@export var tile_map: TileMap

@export var left_down_pos: Vector2i
@export var right_up_pos: Vector2i

@export var time: float

var timer: Timer
var package_loader

var landing_points

func _ready():
	timer = Timer.new()
	add_child(timer)
	landing_points = []
	
	self.package_loader = load("res://PreFabs/package.tscn")
	
	timer.timeout.connect(create_package)
	timer.start(self.time)

func create_package():
	var package = package_loader.instantiate()
	add_child(package)

	var random_gen = RandomNumberGenerator.new()
	
	var x = random_gen.randi_range(left_down_pos.x, right_up_pos.x)
	var y = random_gen.randi_range(left_down_pos.y, right_up_pos.y)
	
	var position = Vector2i(x, y)
	
	for landing_point in self.landing_points:
		if landing_point.point_in_radius():
			position = landing_points.position
			break
	
	package.deploy_position = position
	
	self.deploy_manager.receive_fallable(package)
	
	package.send()
	
	timer.start(self.time)
