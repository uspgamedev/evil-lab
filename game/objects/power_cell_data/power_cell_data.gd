extends Node

const MAX_POWER_CELL = 50
const MIN_POWER_CELL = 0
const POWER_CELL_DEPLETION_RATE = .1

export(int) var initial_power

onready var player = null
onready var tween = get_node('Tween')
onready var power_cell = initial_power
var can_charge = true

func _ready():
	pass

func get_power_cell_energy():
	return power_cell

func activate():
	set_fixed_process(true)

func _fixed_process(delta):
	power_cell_depletion(delta)

func power_cell_depletion(delta):
	if (power_cell > MIN_POWER_CELL):
		power_cell -= POWER_CELL_DEPLETION_RATE*delta

func change_value(object, property, current_value, new_value, time):
	tween.interpolate_property(object, property, current_value, new_value, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.set_repeat(false)
	tween.start()
	yield(tween, 'tween_complete')
	can_charge = true

func transfer(up):
	print("transfer %s" % up)
	if (can_charge):
		if (up):
			can_charge = false
			var power_bank_transfer = min(player.get_power_bank(), min(10, MAX_POWER_CELL - power_cell))
			print(power_bank_transfer)
			player.transfer_power(-power_bank_transfer)
			if (power_bank_transfer != 0):
				change_value(self, 'power_cell', power_cell, power_cell + power_bank_transfer, 1)
			else:
				can_charge = true
		else:
			can_charge = false
			var power_bank_transfer = min(100 - player.get_power_bank(), min(10, power_cell))
			print(power_bank_transfer)
			player.transfer_power(power_bank_transfer)
			if (power_bank_transfer != 0):
				change_value(self, 'power_cell', power_cell, power_cell - power_bank_transfer, 1)
			else:
				can_charge = true
