extends StaticBody2D

const ACT = preload("res://definitions/actions.gd")
const MAX_POWER_CELL = 100
const MIN_POWER_CELL = 0
const POWER_CELL_DEPLETION_RATE = .2

onready var player = null
onready var arrow = get_node("Arrow")
onready var sprite = get_node('Sprite')
onready var label = get_node("Arrow/Label")

onready var power_cell = 30 + randi()%41

func _ready():
	get_tree().get_root().get_node("Main").add_power_cell_on_list(self)
	set_process_input(true)

func power_cell_depletion(delta):
	if (power_cell > MIN_POWER_CELL):
		power_cell -= POWER_CELL_DEPLETION_RATE*delta
	label.set_text(str(int(power_cell)) + '%')
	sprite.set_frame(power_cell/10)

func _input(event):
	var act = ACT.NONE
	if (!arrow.is_hidden()):
		if (event.is_action_pressed("ui_up")):
			var power_bank_transfer = min(player.get_power_bank(), min(10, MAX_POWER_CELL - power_cell))
			player.transfer_power(-power_bank_transfer)
			power_cell += power_bank_transfer
		elif (event.is_action_pressed("ui_down")):
			var power_bank_transfer = min(100 - player.get_power_bank(), min(10, power_cell))
			player.transfer_power(power_bank_transfer)
			power_cell -= power_bank_transfer

func interact(character):
	player = character
	if (!arrow.is_hidden()):
		arrow.hide()
		player.enable_movement()
	else:
		arrow.show()
		player.disable_movement()
