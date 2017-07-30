extends "res://objects/powered_devices/basic_powered_device.gd"

onready var sprite = get_node('Sprite')
onready var is_open = false
onready var open_door = load("res://objects/door/temp-elevator.tex")
onready var closed_door = load("res://objects/door/temp-door.tex")

func interact(character):
	if (power_cell.get_power_cell_energy() > 0):
		if (!is_open):
			sprite.set_texture(open_door)
			is_open = true
		else:
			sprite.set_texture(closed_door)
			is_open = false
