extends StaticBody2D

export(String) var target_room_name
export(String) var spawn_tag
export(bool) var locked = false

signal exit_room(target_room_name, spawn_tag)
signal exit_failed

func unlock():
	locked = false

func interact(character):
	if locked:
		emit_signal("exit_failed")
	else:
		emit_signal("exit_room", self.target_room_name, self.spawn_tag)
