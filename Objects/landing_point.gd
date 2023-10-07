extends Node

class_name LandingPoint

@export var radius: float

var position: Vector2i

func point_in_radius(point: Vector2i) -> bool:
	return (self.position - point).length() < self.radius

