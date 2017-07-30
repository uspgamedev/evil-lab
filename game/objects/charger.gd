extends StaticBody2D

const ACT = preload("res://definitions/actions.gd")
const MAX_LAB_POWER = 500
const MIN_LAB_POWER = 0

onready var sprite = get_node("Sprite")
onready var arrow = get_node('Arrow')
onready var main = get_tree().get_root().get_node('Main')
onready var idle = load('res://objects/wall_outlet_0_empty.tex')
onready var charging = load('res://objects/wall_outlet_0_charging.tex')
onready var player = null
onready var label = get_node("Polygon2D/Label")
onready var tween = get_node('Tween')

var can_charge = true

func _ready():
	set_process_input(true)
	set_fixed_process(true)

func _fixed_process(delta):
	label.set_text(str(max(0, round(main.get_lab_power()/5))) + '%')

func interact(character):
	player = character
	if (!arrow.is_hidden()):
		arrow.hide()
		player.enable_movement()
		sprite.set_texture(idle)
		sprite.set_hframes(1)
	else:
		arrow.show()
		player.disable_movement()
		sprite.set_texture(charging)
		sprite.set_hframes(16)

func _input(event):
	var act = ACT.NONE
	if (!arrow.is_hidden() and can_charge):
		if (event.is_action_pressed("ui_up")):
			can_charge = false
			var power_bank_transfer = round(min(player.get_power_bank(), min(10, MAX_LAB_POWER - main.get_lab_power())))
			player.transfer_power(-power_bank_transfer)
			if (power_bank_transfer != 0):
				main.change_value(power_bank_transfer, self)
				sprite.set_frame(player.get_power_bank()/6)
			else:
				can_charge = true
		elif (event.is_action_pressed("ui_down")):
			can_charge = false
			var power_bank_transfer = round(min(100 - player.get_power_bank(), min(10, main.get_lab_power())))
			player.transfer_power(power_bank_transfer)
			if (power_bank_transfer != 0):
				main.change_value(-power_bank_transfer, self)
				sprite.set_frame(player.get_power_bank()/6)
			else:
				can_charge = true
