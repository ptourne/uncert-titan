extends Node

class_name DeployManager

@export var map: Map;

func receive_fallable(fallable: Fallable):
	fallable.new_position.connect(map.hanldle_new_position)

func _ready():
	pass

func _process(delta):
	pass
