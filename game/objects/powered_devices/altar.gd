extends "res://objects/powered_devices/basic_powered_device.gd"

onready var tween = get_node('Tween')
onready var light = get_node('Light2D')

func change_value(tween, object, property, current_value, new_value, time):
	tween.interpolate_property(object, property, current_value, new_value, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.set_repeat(false)
	tween.start()

func _ready():
	light.hide()
	set_fixed_process(true)

func _fixed_process(delta):
	if (power_cell.get_power_cell_energy() > 0):
		if(light.is_hidden()):
			change_value(tween, light, 'energy', 0, 0.2, float(1)/3)
			light.show()
		else:
			if (light.get_energy() == 0.8):
				change_value(tween, light, 'energy', 0.8, 0.2, 1)
			elif (light.get_energy() == 0.2):
				change_value(tween, light, 'energy', 0.2, 0.8, 1)
	else:
		light.hide()

func interact(character):
	if (power_cell.get_power_cell_energy() > 0):
		get_tree().quit()
