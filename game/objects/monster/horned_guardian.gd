extends Node2D

signal landed

onready var anim = get_node("AnimationPlayer")

func _ready():
	set_fixed_process(true)

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
	get_tree().quit()
