extends "res://objects/powered_devices/basic_powered_device.gd"

onready var sprite = get_node('Sprite')
onready var is_open = false
onready var open_door = load("res://objects/powered_devices/metal_door_open.tex")
onready var closed_door = load("res://objects/powered_devices/metal_door_closed.tex")

export(String) var target_room_name
export(String) var spawn_tag

signal exit_room(target_room_name, spawn_tag)

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if (has_power()):
		sprite.set_texture(closed_door)
		is_open = false
	else:
		sprite.set_texture(open_door)
		is_open = true

func interact(character):
	if (is_open):
		emit_signal("exit_room", self.target_room_name, self.spawn_tag)
