extends AssistantSender

class_name SendMessage

var contador: int = 0

func send_message(text: String):
	contador += 1
	self.assign_text.emit(text + " " + str(contador))
