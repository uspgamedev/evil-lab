extends StaticBody2D

var progress_bar
var tween

func interact(character):
	progress_bar = get_node("ProgressBar")
	progress_bar.show()
	tween = progress_bar.get_node("Tween")
	tween.interpolate_property(progress_bar, "range/value", 0, 100, 4, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	tween.set_repeat(false)
	tween.start()
	yield(tween, "tween_complete")
	progress_bar.hide()
