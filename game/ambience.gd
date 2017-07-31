extends StreamPlayer

onready var fader = get_node("fader")

func _ready():
	fader.interpolate_method(self, "set_volume", 0, 24, 3, Tween.TRANS_LINEAR,
			Tween.EASE_IN_OUT)
	fader.start()
	yield(fader, "tween_complete")
	print(get_volume())


