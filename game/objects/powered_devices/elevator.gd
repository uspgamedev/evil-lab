extends "res://objects/powered_devices/basic_powered_device.gd"

onready var sprite = get_node('Sprite')
onready var open = load('res://objects/powered_devices/lift_on.tex')
onready var closed = load('res://objects/powered_devices/lift_off.tex')

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if (power_cell.get_power_cell_energy() > 0):
		sprite.set_texture(open)
	else:
		sprite.set_texture(closed)

func interact(character):
	if (power_cell.get_power_cell_energy() > 0):
		print('enter elevator')
