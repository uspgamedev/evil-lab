
extends Node2D

export (StringArray) var PHRASES
export (String, FILE, "*.tscn") var MAIN_MENU_PATH

onready var tween = get_node("tween")
onready var death_text = get_node("death_text")
onready var input = get_node("input")

func _ready():
	randomize()
	var idx = randi() % PHRASES.size()
	var current_phrase = PHRASES[idx]
	show_text(current_phrase)

func show_text(current_phrase):
	print("gameover text:")
	print(current_phrase)
	death_text.set_text(current_phrase)
	tween.interpolate_method(death_text, "set_opacity", 0, 1, 2,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_complete")
	input.connect("pressing_act", self, "goback")
	print("ok, now press the button!")

func goback(action_pressed):
	print("button pressed!")
	tween.interpolate_method(death_text, "set_opacity", 1, 0, 1.25,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_complete")
	get_tree().change_scene(MAIN_MENU_PATH)


