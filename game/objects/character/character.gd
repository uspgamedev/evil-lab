extends 'res://objects/body.gd'

const ACT = preload("res://definitions/actions.gd")
const MAX_POWER = 4
const MAX_BATTERY = 1

var light_battery = MAX_BATTERY
var power_bank = MAX_POWER
var interactable
var timer = 0

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	battery_depletion(delta)

func battery_depletion(delta):
	if (light_battery > 0.1):
		timer += delta
		if (timer >= 1):
			timer = 0
			light_battery -= 0.1
			get_node("Light2D").set_energy(light_battery)

func recharge_power_bank():
	power_bank = MAX_POWER

func set_nearby_interactable(object):
	interactable = object

func _pressing_act(act):
	if (act == ACT.LIGHT):
		if (self.get_node("Light2D").is_hidden()):
			self.get_node("Light2D").show()
		else:
			self.get_node("Light2D").hide()
	if (act == ACT.RELOAD):
		light_battery = MAX_BATTERY
	if (act == ACT.INTERACT):
		if (interactable != null):
			interactable.interact(self)
