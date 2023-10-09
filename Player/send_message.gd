extends AssistantSender

class_name SendMessage

func send_message(text: String):
	self.assign_text.emit(text)
