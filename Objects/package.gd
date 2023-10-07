extends Fallable

class_name Package

var deploy_position: Vector2i

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func send():
	self.new_position.emit(self.deploy_position, self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

