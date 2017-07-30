extends Node2D

const CHARACTER = preload("res://objects/character/character.tscn")

export(String) var first_room

onready var character = CHARACTER.instance()
onready var rooms = {}

var current_room = null
var power_cell_list = []

func _ready():
	var room = get_node("Room")
	if room == null:
		_move_to_room(first_room, "Start")
	set_fixed_process(true)

func _fixed_process(delta):
	power_cell_depletion_management(delta)

func power_cell_depletion_management(delta):
	for i in power_cell_list:
		i.power_cell_depletion(delta)

func add_power_cell_on_list(power_cell):
	power_cell_list.append(power_cell)

func _move_to_room(room_name, spawn_tag):
	var room = _load_room(room_name)
	if self.current_room != null:
		self.current_room.disconnect("character_exited", self, "_move_to_room")
		self.current_room.remove_child(character)
		remove_child(self.current_room)
		yield(get_tree(), "fixed_frame")
	var spawn_pos = room.get_node(spawn_tag).get_pos()
	self.character.set_pos(spawn_pos)
	self.character.speed = 0
	room.add_child(self.character)
	self.current_room = room
	add_child(room)
	move_child(room, 0)
	room.connect("character_exited", self, "_move_to_room")
	assert(room.is_connected("character_exited", self, "_move_to_room"))

func _load_room(name):
	var room
	if rooms.has(name):
		room = rooms[name]
	else:
		room = load("res://room/%s.tscn" % name).instance()
		rooms[name] = room
	return room
