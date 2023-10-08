extends Node

class_name Descriptable

signal show_description(description: String)
signal hide_description()

@export var popup_manager: PopUpManager

var set_connection: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_connection = connect_to_manager()

func connect_to_manager() -> bool:
	return popup_manager.connect_popup(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !self.set_connection:
		self.set_connection = connect_to_manager()

func emit_description(text: String):
	show_description.emit(text)

func emit_hide():
	hide_description.emit()
