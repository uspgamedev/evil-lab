extends "res://objects/body.gd"

const CHASE_DIST = 640

var character

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if character != null:
		var dir = character.get_pos() - get_pos()
		var dist = dir.length_squared()
		if dist <= CHASE_DIST*CHASE_DIST:
			push(dir.normalized())
