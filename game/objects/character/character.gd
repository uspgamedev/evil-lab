extends 'res://objects/body.gd'

const ACT = preload("res://definitions/actions.gd")
const MAX_POWER = 100
const MAX_BATTERY = 20

var light_battery = MAX_BATTERY
var power_bank = MAX_POWER
var interactable
var timer = 0
onready var light = get_node("Light2D")
onready var power_tween = get_node("PowerTween")
onready var light_tween = get_node("LightTween")
onready var energy_tween = get_node("EnergyTween")

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	battery_depletion(delta)
	light.set_energy(float(light_battery)/20)

func battery_depletion(delta):
	if (light_battery > 2):
		timer += delta
		if (timer >= 1):
			timer = 0
			light_battery -= 2

func recharge_power_bank():
	var timer = 0
	while (power_bank < MAX_POWER):
		timer += 1
		if (timer > 120):
			timer = 0
			power_bank += 10

func set_nearby_interactable(object):
	interactable = object

func reload_light_battery():
	var time = 1 - float(light_battery)/MAX_BATTERY
	change_value(power_tween, self, "power_bank", power_bank, power_bank-(MAX_BATTERY-light_battery), time)
	get_tree().get_root().get_node("Main/HUD/ProgressBar").change_value(power_bank-(MAX_BATTERY-light_battery), time)
	change_value(light_tween, self, "light_battery", light_battery, MAX_BATTERY, time)
	#change_value(energy_tween, light, 'energy', light.get_energy(), float(light_battery)/20, time)

func change_value(tween, object, property, current_value, new_value, time):
	tween.interpolate_property(object, property, current_value, new_value, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.set_repeat(false)
	tween.start()

func _pressing_act(act):
	if (act == ACT.LIGHT):
		if (self.light.is_hidden()):
			self.light.show()
		else:
			self.light.hide()
	if (act == ACT.RELOAD):
		reload_light_battery()
	if (act == ACT.INTERACT):
		if (interactable != null):
			interactable.interact(self)
