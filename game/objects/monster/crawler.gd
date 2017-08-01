extends "res://objects/body.gd"

const CHASE_DIST = 360
const SPEED_FACTOR = 2*10

onready var sfx = get_node("SamplePlayer2D")
onready var timer = get_node("Timer")

var character = null
var sacrifice = false
var direction = 1
var target

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
		push((pos - get_pos()).normalized()/SPEED_FACTOR)

func start_sacrifice():
	sacrifice = true
	target = get_node("../Target")

func cry():
	sfx.go()
	timer.set_wait_time(5*randf())
	timer.start()

func check_character( body ):
	if body == character:
		if (get_pos() - body.get_pos()).length_squared() <= 160*160:
			body.die()
