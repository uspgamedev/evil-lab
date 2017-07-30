extends StaticBody2D

const ACT = preload("res://definitions/actions.gd")
const MAX_POWER_CELL = 100

onready var player = null
onready var arrow = get_node("Arrow")
onready var sprite = get_node('Sprite')
onready var label = get_node("Arrow/Label")

var power_cell = 50

func _ready():
	sprite.set_frame(power_cell/10)
	set_process_input(true)

func _input(event):
	var act = ACT.NONE
	if (!arrow.is_hidden()):
		if (event.is_action_pressed("ui_up")):
			var power_bank_transfer = min(player.get_power_bank(), min(10, MAX_POWER_CELL - power_cell))
			player.transfer_power(-power_bank_transfer)
			power_cell += power_bank_transfer
			label.set_text(str(power_cell) + '%')
		elif (event.is_action_pressed("ui_down")):
			var power_bank_transfer = min(100 - player.get_power_bank(), min(10, power_cell))
			player.transfer_power(power_bank_transfer)
			power_cell -= power_bank_transfer
			label.set_text(str(power_cell) + '%')
		sprite.set_frame(power_cell/10)

func interact(character):
	player = character
	if (!arrow.is_hidden()):
		arrow.hide()
	else:
		arrow.show()
