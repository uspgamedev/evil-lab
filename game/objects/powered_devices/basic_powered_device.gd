extends StaticBody2D

const POWER_CELL = preload("res://objects/power_cell_data/power_cell_data.gd")

export (String) var power_cell_id

onready var power_cell = get_tree().get_root().get_node("Main").get_power_cell(power_cell_id)

func _ready():
	power_cell.activate()

func get_power():
	return power_cell.get_power_cell_energy()
