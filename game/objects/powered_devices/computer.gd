extends "res://objects/powered_devices/basic_powered_device.gd"

onready var off = load('res://objects/powered_devices/computer_1_off.tex')
onready var on = load('res://objects/powered_devices/computer_1_on.tex')

onready var sprite = get_node('Sprite')
onready var anim = sprite.get_node('AnimationPlayer')
onready var sound = get_node('StreamPlayer')
onready var speech = get_node('Speech')

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if (has_power()):
		sprite.set_texture(on)
		sprite.set_hframes(2)
		if (!anim.is_playing()):
			sprite.get_node("AnimationPlayer").play('on')
	else:
		sprite.get_node("AnimationPlayer").stop()
		sprite.set_texture(off)
		sprite.set_hframes(1)
		sprite.set_frame(0)

func interact(character):
	if (has_power()):
		sound.play()
		speech.go()
		get_node("/root/Main/Events/UnlockBasement").go()
