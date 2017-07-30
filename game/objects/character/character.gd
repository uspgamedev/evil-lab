extends 'res://objects/body.gd'

const ACT = preload("res://definitions/actions.gd")
const MAX_POWER = 100
const MAX_BATTERY = 22
const MIN_BATTERY = 2
const BATTERY_DEPLETION_RATE = .4

var light_battery = MAX_BATTERY
var power_bank = MAX_POWER/10.0
var interactable
var lock = false
var stored_battery
var light_on = true
onready var light = get_node("Lamp/Light2D")
onready var power_tween = get_node("PowerTween")
onready var light_tween = get_node("LightTween")

func _ready():
	var floor_level = get_pos()
	floor_level.y = 0
	set_pos(floor_level)
	set_fixed_process(true)
	get_tree().get_root().get_node("Main/HUD/ProgressBar").change_value(power_bank, 1)

func _fixed_process(delta):
	battery_depletion(delta)
	light.set_energy(float(int(light_battery))/20)

func get_light_percent():
	return light_battery/MAX_BATTERY

func battery_depletion(delta):
	if (light_on and light_battery > MIN_BATTERY):
		light_battery -= BATTERY_DEPLETION_RATE*delta

func set_nearby_interactable(object):
	self.interactable = object

func unset_nearby_interactable(object):
	if self.interactable == object:
		self.interactable = null

func reload_light_battery():
	if (light_on and power_bank > 0):
		var time = 1 - light_battery/MAX_BATTERY
		var power_bank_transfer = power_bank-min(power_bank, (MAX_BATTERY-light_battery))
		change_value(power_tween, self, "power_bank", power_bank, power_bank_transfer, time)
		get_tree().get_root().get_node("Main/HUD/ProgressBar").change_value(power_bank_transfer, time)
		change_value(light_tween, self, "light_battery", light_battery, MAX_BATTERY, time)

func change_value(tween, object, property, current_value, new_value, time):
	tween.interpolate_property(object, property, current_value, new_value, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.set_repeat(false)
	tween.start()

func _pressing_act(act):
	if (act == ACT.LIGHT):
		if (!light_on):
			light_on = true
			light_battery = stored_battery
		else:
			light_on = false
			stored_battery = light_battery
			light_battery = MIN_BATTERY
	if (act == ACT.RELOAD):
		reload_light_battery()
	if (act == ACT.INTERACT):
		if (interactable != null):
			interactable.interact(self)

func transfer_power(power):
	power_bank += power
	get_tree().get_root().get_node("Main/HUD/ProgressBar").change_value(power_bank, 1)

func get_power_bank():
	return power_bank

func enable_movement():
	ACC = 240

func disable_movement():
	ACC = 0
