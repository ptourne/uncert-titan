extends Node

class_name PopUpManager

var popup_label: PopUp

func _ready():
	popup_label = null

func connect_popup(descriptable: Descriptable) -> bool:
	if popup_label == null:
		return false
	
	descriptable.show_description.connect(popup_label.show_description)
	descriptable.hide_description.connect(popup_label.hide_description)
	return true
