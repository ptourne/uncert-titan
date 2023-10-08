extends Node

class_name AssistantManager

var text: TextAssistant

func _ready():
	self.text = null

func send_text(sender: AssistantSender) -> bool:
	if text != null:
		sender.assign_text.connect(text.change_text)
		return true
	return false
