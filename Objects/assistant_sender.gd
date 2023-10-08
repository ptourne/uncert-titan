extends Node

class_name AssistantSender

signal assign_text(text: String)

@export var assistant_manager: AssistantManager

var set_assistant: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_assistant = connect_to_manager()

func connect_to_manager() -> bool:
	return assistant_manager.send_text(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !self.set_assistant:
		self.set_assistant = connect_to_manager()
