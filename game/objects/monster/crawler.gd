extends "res://objects/body.gd"

const CHASE_DIST = 360

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
			push(dir.normalized()/3.0/20.0)
	else:
		if randf() > 0.95:
			direction *= -1
		push(direction*Vector2(1,0)/20.0)

func start_sacrifice(target):
	pass
