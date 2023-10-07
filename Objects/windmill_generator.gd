extends Node

const ENERGY_AMOUNT = 10

signal send_energy(amount)

func _on_energy_emiting_timer_timeout():
	send_energy.emit(ENERGY_AMOUNT)
