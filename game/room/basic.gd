extends Node2D

signal character_exited(room_name, spawn_tag)

var character

func _ready():
	character = get_node("Character")
	assert(character != null)
	for obj in get_children():
		for prop in obj.get_property_list():
			if prop.name == "character":
				obj.character = character

func exit_room(target_room_name, spawn_tag):
	emit_signal("character_exited", target_room_name, spawn_tag)
