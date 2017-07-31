extends StaticBody2D

const ACT = preload("res://definitions/actions.gd")
const POWER_CELL_DATA = preload("res://objects/power_cell_data/power_cell_data.gd")

export(String) var power_cell_id

onready var player = null
onready var arrow = get_node("Arrow")
onready var sprite = get_node('Sprite')
onready var label = get_node("Arrow/Label")
onready var data = get_tree().get_root().get_node("Main").get_power_cell(power_cell_id)

signal interaction_started
signal interaction_ended

func _ready():
	set_process_input(true)
	set_process(true)
	data.activate()

func _process(delta):
	var percent = 1.0*data.get_power_cell_energy()/POWER_CELL_DATA.MAX_POWER_CELL
	label.set_text(str(max(0, round(100*percent))) + '%')
	sprite.set_frame(int(percent*10))

func _input(event):
	var act = ACT.NONE
	if (!arrow.is_hidden()):
		if (event.is_action_pressed("ui_up")):
			data.transfer(true)
		elif (event.is_action_pressed("ui_down")):
			data.transfer(false)

func interact(character):
	player = character
	if (!arrow.is_hidden()):
		arrow.hide()
		player.enable_movement()
		emit_signal("interaction_ended")
	else:
		arrow.show()
		player.disable_movement()
		emit_signal("interaction_started")

func get_power_cell_energy():
	return data.get_power_cell_energy()
