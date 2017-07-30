extends StaticBody2D

export(String) var target_room_name
export(String) var spawn_tag

signal exit_room(target_room_name, spawn_tag)

func interact(character):
	emit_signal("exit_room", self.target_room_name, self.spawn_tag)
