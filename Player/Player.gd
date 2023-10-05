extends CharacterBody2D

const WALKING_ACCELERATION = 600
const RUNNIN_ACCELERATION = 1000
const MAX_WALKING_SPEED = 80
const MAX_RUNNIN_SPEED = 150
const MAX_SPEED = 150
const WALKING_FRICTION = 800
const RUNNIN_FRICTION = 1200

var running = false

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
