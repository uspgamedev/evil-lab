extends Area2D

const CHARACTER = preload("res://objects/character/character.gd")

func _on_Area2D_body_enter(body):
	if body extends CHARACTER:
		body.set_nearby_interactable(get_parent())

func _on_Area2D_body_exit(body):
	if body extends CHARACTER:
		body.unset_nearby_interactable(get_parent())
