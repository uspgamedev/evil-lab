extends 'res://objects/body.gd'

const ACT = preload("res://definitions/actions.gd")

var battery = 10
var interactable

func set_nearby_interactable(object):
	interactable = object

func _pressing_act(act):
	if (act == ACT.LIGHT):
		if (self.get_node("Light2D").is_hidden()):
			self.get_node("Light2D").show()
		else:
			self.get_node("Light2D").hide()
	if (act == ACT.RELOAD):
		pass
	if (act == ACT.INTERACT):
		if (interactable != null):
			interactable.interact(self)
