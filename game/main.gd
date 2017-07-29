extends Node2D

const CHARACTER = preload("res://objects/character/character.tscn")

export(String) var first_room

onready var character = CHARACTER.instance()
onready var rooms = {}

var current_room = null

func _ready():
	_move_to_room(_load_room(first_room), "start")

func _move_to_room(room, spawn_tag):
	if self.current_room != null:
		self.currnet_room.disconnect("character_exited", self, "_move_to_room")
		self.current_room.remove_child(character)
		yield(self.character, "exit_tree")
		remove_child(self.current_room)
		yield(self.current_room, "exit_tree")
	room.add_child(self.character)
	self.character.set_pos(room.get_node(spawn_tag).get_pos())
	yield(self.character, "enter_tree")
	self.current_room = room
	add_child(room)
	move_child(room, 0)
	yield(room, "enter_tree")
	room.connect("character_exited", self, "_move_to_room")

func _load_room(name):
	var room = rooms[name]
	if room == null:
		room = load("res://room/%s.tscn" % name)
	return room
