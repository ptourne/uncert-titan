extends Control

class_name InGame

@export var base : Base
@export var player : Player

@onready var base_oxigen_progress_bar = $AssistantFrame/Margin/MainFrame/Indicators/Oxigen/ProgressBar
@onready var suit_oxigen_progress_bar = $SuitFrame/Margin/Stats/Indicators/Oxigen/ProgressBar
@onready var base_energy_progress_bar = $AssistantFrame/Margin/MainFrame/Indicators/Energy/ProgressBar
@onready var suit_energy_progress_bar = $SuitFrame/Margin/Stats/Indicators/Energy/ProgressBar

func _ready():
	base.energy_change.connect(_set_base_energy_level_indicator)
	player.energy_change.connect(_set_player_energy_level_indicator)
	base.oxigen_change.connect(_set_base_oxigen_level_indicator)
	player.oxigen_change.connect(_set_player_oxigen_level_indicator)
										
func _set_base_energy_level_indicator(amount):
	base_energy_progress_bar.value = amount

func _set_player_energy_level_indicator(amount):
	suit_energy_progress_bar.value = amount

func _set_base_oxigen_level_indicator(amount):
	base_oxigen_progress_bar.value = amount

func _set_player_oxigen_level_indicator(amount):
	suit_oxigen_progress_bar.value = amount
