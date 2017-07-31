extends "res://objects/body.gd"

const CHASE_DIST = 640

onready var sprite = get_node("Sprite")

var character = null
var intensity = 0

var flicker_time = 0
var flicker = 0

func _ready():
	set_fixed_process(true)
	set_process(true)

func _fixed_process(delta):
	if character != null:
		var dir = character.get_pos() - get_pos()
		var dist = dir.length()
		intensity = max(0, (640 - dist)/640)*(1.0 - character.get_light_percent()/2.0)
		if dist <= CHASE_DIST and intensity > 0.4:
			push(dir.normalized()/2.0)

func _process(delta):
	flicker_time += delta
	flicker = 10*intensity*sin(intensity*4*2*PI*flicker_time)
	if flicker + randf()*3*intensity > 2:
		sprite.show()
	else:
		sprite.hide()
	if randf() > 0.8:
		sprite.set_frame(randi()%3)
		sprite.set_flip_h(randf() > 0.5)

func check_character(body):
	if body == character:
		if (get_pos() - body.get_pos()).length_squared() <= 160*160:
			character.die()
