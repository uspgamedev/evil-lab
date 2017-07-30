extends Area2D

const CHARACTER = preload("res://objects/character/character.gd")

export(bool) var oneshot = true

signal triggered

func _ready():
	pass

func _check_character(body):
	print("check")
	if body extends CHARACTER:
		print("huzzah")
		emit_signal("triggered")
		if oneshot:
			disconnect(self, "enter_body", "_check")

func _noop(body):
	pass
