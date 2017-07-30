extends "res://objects/powered_devices/basic_powered_device.gd"

onready var sprite = get_node('Sprite')

func interact(character):
	if (power_cell.get_power_cell_energy() > 0):
		print('enter elevator')
