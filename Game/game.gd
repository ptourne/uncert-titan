extends Node

class_name GameManager

@export var player : Player

signal toggle_game_paused(is_paused: bool)

var game_paused: bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_game_paused", game_paused)

func _ready():
	player.connect("die", _die)

func _die(message):
	print(message)

func _input(event: InputEvent):
	if (event.is_action_pressed("ui_cancel")):
		game_paused = !game_paused
