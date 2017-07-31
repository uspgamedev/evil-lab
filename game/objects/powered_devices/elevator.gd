extends "res://objects/powered_devices/basic_powered_device.gd"

onready var sprite = get_node('Sprite')
onready var open = load('res://objects/powered_devices/lift_on.tex')
onready var closed = load('res://objects/powered_devices/lift_off.tex')

export(String) var target_room_name
export(String) var spawn_tag

signal character_exited(room_name, spawn_tag)

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if (has_power()):
		sprite.set_texture(open)
	else:
		sprite.set_texture(closed)

func interact(character):
	print("yo")
	if (has_power()):
		print("coming up")
		emit_signal("character_exited", self.target_room_name, self.spawn_tag)
