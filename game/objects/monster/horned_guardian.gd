extends Node2D

export (NodePath) var character

signal landed

onready var anim = get_node("AnimationPlayer")
onready var sfx = get_node("SFX")

func _ready():
	set_fixed_process(true)
	sfx.go()

func _fixed_process(delta):
	if (get_pos().y < 0):
		set_pos(get_pos() + Vector2(0,4000)*delta)
		if get_pos().y >= 0:
			var pos = get_pos()
			pos.y = 0
			set_pos(pos)
			emit_signal("landed")

func _within_reach():
	anim.play("gouge")
	yield(anim, "finished")
	character.die()
