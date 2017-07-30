extends "res://objects/powered_devices/basic_powered_device.gd"

onready var sprite = get_node('Sprite')
onready var anim = sprite.get_node('AnimationPlayer')
onready var off = load('res://objects/powered_devices/computer_1_off.tex')
onready var on = load('res://objects/powered_devices/computer_1_on.tex')

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if (power_cell.get_power_cell_energy() > 0):
		sprite.set_texture(on)
		sprite.set_hframes(2)
		if (!anim.is_playing()):
			sprite.get_node("AnimationPlayer").play('on')
	else:
		sprite.get_node("AnimationPlayer").stop()
		sprite.set_texture(off)
		sprite.set_hframes(1)

func interact(character):
	if (power_cell.get_power_cell_energy() > 0):
		print('hacking')
