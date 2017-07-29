extends Area2D

func _on_Area2D_body_enter(body):
	body.set_nearby_interactable(get_parent())

func _on_Area2D_body_exit(body):
	body.set_nearby_interactable(null)
