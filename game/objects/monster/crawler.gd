extends "res://objects/body.gd"

const CHASE_DIST = 360
const SPEED_FACTOR = 2*10

var character = null
var sacrifice = false
var direction = 1

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

func start_sacrifice(target):
	pass
