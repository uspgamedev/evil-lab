extends Area2D

func _on_Area2D_body_enter(body):
	body.enable_charging()

func _on_Area2D_body_exit(body):
	body.disable_charging()
