extends Node2D

export (String, FILE, "*.tscn") var RESTART_SCENE_PATH

onready var tween = get_node("tween")
onready var timer = get_node("tween/timer")
onready var bgm = get_node("tween/bgm")
onready var blocks = get_children()

func _ready():
	hide_all()
	var i = 0
	for block in blocks:
		if block != tween:
			# fade in
			block.set_opacity(0)
			block.show()
			tween.interpolate_method(block, "set_opacity", 0, 1, 2,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			tween.start()
			yield(tween, "tween_complete")
			# wait
			timer.start()
			yield(timer, "timeout")
			# fade out
			tween.interpolate_method(block, "set_opacity", 1, 0, 2,
					Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			tween.start()
			yield(tween, "tween_complete")
			block.hide()
	tween.interpolate_method(bgm, "set_volume", 1, 0, 2,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_complete")
	get_tree().change_scene(RESTART_SCENE_PATH)

func hide_all():
	for block in blocks:
		if block != tween:
			block.hide()



