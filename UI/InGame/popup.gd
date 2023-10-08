extends Label

class_name PopUp

@export var container: PanelContainer

var visibility: bool

func _ready():
	set_visibility(false)
	
func set_visibility(state: bool):
	container.show() if state else container.hide()
	self.visibility = state

func show_description(description: String):
	set_visibility(true)
	self.text = description

func hide_description():
	set_visibility(false)
