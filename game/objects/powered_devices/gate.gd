extends "res://objects/powered_devices/basic_powered_device.gd"

onready var bot = get_node('Bottom')
onready var top = get_node('Top')
onready var bot_tween = get_node('BotTween')
onready var top_tween = get_node('TopTween')
onready var anim = get_node('AnimationPlayer')
var is_open = false

func interact(character):
	pass

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if (!has_power() and !is_open):
		is_open = true
		anim.play('open')
		#change_value(bot_tween, bot, "transform/pos", bot.get_pos(), bot.get_pos() + Vector2(0, 120), 2)
		#change_value(top_tween, top, "transform/pos", top.get_pos(), top.get_pos() - Vector2(0, 120), 2)
	elif (has_power() and is_open):
		is_open = false
		anim.play('closed')
		#change_value(bot_tween, bot, "transform/pos", bot.get_pos(), bot.get_pos() - Vector2(0, 120), 2)
		#change_value(top_tween, top, "transform/pos", top.get_pos(), top.get_pos() + Vector2(0, 120), 2)

func change_value(tween, object, property, current_value, new_value, time):
	tween.interpolate_property(object, property, current_value, new_value, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.set_repeat(false)
	tween.start()
