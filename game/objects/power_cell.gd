extends StaticBody2D

const ACT = preload("res://definitions/actions.gd")
const MAX_POWER_CELL = 50
const MIN_POWER_CELL = 0
const POWER_CELL_DEPLETION_RATE = .1

onready var player = null
onready var arrow = get_node("Arrow")
onready var sprite = get_node('Sprite')
onready var label = get_node("Arrow/Label")
onready var tween = get_node('Tween')
onready var power_cell = 0
var can_charge = true

func _ready():
	get_tree().get_root().get_node("Main").add_power_cell_on_list(self)
	set_process_input(true)

func power_cell_depletion(delta):
	if (power_cell > MIN_POWER_CELL):
		power_cell -= POWER_CELL_DEPLETION_RATE*delta
	label.set_text(str(max(0, round(power_cell*2))) + '%')
	sprite.set_frame(power_cell/5)

func change_value(object, property, current_value, new_value, time):
	tween.interpolate_property(object, property, current_value, new_value, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.set_repeat(false)
	tween.start()
	yield(tween, 'tween_complete')
	can_charge = true

func _input(event):
	var act = ACT.NONE
	if (!arrow.is_hidden() and can_charge):
		if (event.is_action_pressed("ui_up")):
			can_charge = false
			var power_bank_transfer = min(player.get_power_bank(), min(10, MAX_POWER_CELL - power_cell))
			player.transfer_power(-power_bank_transfer)
			change_value(self, 'power_cell', power_cell, power_cell + power_bank_transfer, 1)
		elif (event.is_action_pressed("ui_down")):
			can_charge = false
			var power_bank_transfer = min(100 - player.get_power_bank(), min(10, power_cell))
			player.transfer_power(power_bank_transfer)
			change_value(self, 'power_cell', power_cell, power_cell - power_bank_transfer, 1)

func interact(character):
	player = character
	if (!arrow.is_hidden()):
		arrow.hide()
		player.enable_movement()
	else:
		arrow.show()
		player.disable_movement()

func get_power_cell_energy():
	return power_cell
