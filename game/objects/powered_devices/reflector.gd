extends "res://objects/powered_devices/basic_powered_device.gd"

onready var sprite = get_node('Sprite')
onready var light = get_node('Light2D')
onready var off = load('res://objects/powered_devices/reflector_off_0.tex')
onready var on = load('res://objects/powered_devices/reflector_on_0.tex')

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if (has_power()):
		sprite.set_texture(on)
		light.show()
	else:
		sprite.set_texture(off)
		light.hide()
	if (!light.is_hidden()):
		light.set_energy(get_power()/POWER_CELL.MAX_POWER_CELL)

func interact(character):
	pass
