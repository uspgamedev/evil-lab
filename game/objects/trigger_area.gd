extends Area2D

const CHARACTER = preload("res://objects/character/character.gd")

export(bool) var oneshot = true

signal triggered

func _ready():
	for shape in get_children():
		add_shape(shape.get_shape())
	yield(get_tree(), "fixed_frame")
	connect("body_enter", self, "_check_character")

func _check_character(body):
	if body extends CHARACTER:
		emit_signal("triggered", body)
		if oneshot:
			disconnect("body_enter", self, "_check_character")
