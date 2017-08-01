extends "res://objects/body.gd"

const CHASE_DIST = 360
const SPEED_FACTOR = 2*10

onready var sfx = get_node("SamplePlayer2D")
onready var scream = get_node("SFX")
onready var timer = get_node("Timer")

var character = null
var sacrifice = false
var direction = 1
var target

var scream_voice = -1

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if character != null and !sacrifice:
		var dir = character.get_pos() - get_pos()
		var dist = dir.length()
		if dist < CHASE_DIST:
			push(dir.normalized()/SPEED_FACTOR)
		else:
			if randf() > 0.97:
				direction *= -1
			push(direction*Vector2(1,0)/SPEED_FACTOR)
	elif sacrifice:
		var pos = target.get_pos()
		var dir = pos - get_pos()
		push(dir.normalized()/SPEED_FACTOR)
		if (dir.length_squared() < 40*40) and !target.is_emitting():
			target.set_emitting(true)
			scream_voice = scream.go()
			#if scream.is_voice_active(scream_voice):
			#	print("scream")	

func start_sacrifice():
	sacrifice = true
	target = get_node("../Target")
	get_node("../Block").set_layer_mask(1)

func cry():
	sfx.go()
	timer.set_wait_time(5*randf())
	timer.start()

func check_character( body ):
	if body == character:
		if (get_pos() - body.get_pos()).length_squared() <= 160*160:
			body.die()
