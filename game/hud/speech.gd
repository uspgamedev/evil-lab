extends Node

export(bool) var autostart = false

onready var speech_label = get_tree().get_root().get_node("Main/HUD/Speech")

func _ready():
	if autostart:
		go()

func go(unused=null):
	speech_label.queue_speech(self)
