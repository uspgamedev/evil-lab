extends ProgressBar

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func change_value(new_value):
	var tween = get_node("Tween")
	var current_value = get_value()
	tween.interpolate_property(self, "value", current_value, new_value, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
