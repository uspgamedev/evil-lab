extends ProgressBar

const CONST = preload("res://definitions/constants.gd")

func _ready():
	change_value(100, CONST.EPSILON)

func change_value(new_value, time):
	var tween = get_node("Tween")
	var current_value = get_value()
	tween.interpolate_property(self, "range/value", current_value, new_value, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.set_repeat(false)
	tween.start()
