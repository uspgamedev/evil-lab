extends Node2D

const CHARACTER = preload("res://objects/character/character.tscn")
const FADER = preload("res://effects/fader.tscn")
const MAX_LAB_POWER = 300
const MIN_LAB_POWER = 0
const LAB_POWER_DEPLETION_RATE = .3

export (String, FILE, "*.tscn") var GAMEOVER_PATH
export (String) var first_room

onready var character = CHARACTER.instance()
onready var power_cells = get_node("PowerCells")
onready var rooms = {}
var lab_power = MAX_LAB_POWER*0.80
var tween

var current_room = null
var power_cell_list = []
var power_cell_name_list = []

func _ready():
	character.connect("end_game", self, "end_game")
	tween = Tween.new()
	self.add_child(tween)
	var room = get_node("Room")
	if room == null:
		_move_to_room(first_room, "Start")
	for power_cell in power_cells.get_children():
		power_cell.player = self.character
	set_fixed_process(true)

func get_power_cell(id):
	return power_cells.get_node(id)

func _fixed_process(delta):
	power_cell_depletion_management(delta)

func power_cell_depletion_management(delta):
	for i in power_cell_list:
		i.power_cell_depletion(delta)

func add_power_cell_on_list(power_cell):
	power_cell_list.append(power_cell)
	power_cell_name_list.append(power_cell.get_name())

func find_power_cell(powered_device):
	return power_cell_list[power_cell_name_list.find("PowerCell" + powered_device.get_name())]

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

func get_lab_power():
	return lab_power

func update_lab_power(new_value):
	lab_power = new_value

func lab_power_depletion(delta):
	if (lab_power > MIN_LAB_POWER):
		lab_power -= LAB_POWER_DEPLETION_RATE*delta

func change_value(power_bank_transfer, charger):
	change_value2(charger, self, 'lab_power', lab_power, lab_power + power_bank_transfer, 1)

func change_value2(charger, object, property, current_value, new_value, time):
	tween.interpolate_property(object, property, current_value, new_value, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.set_repeat(false)
	tween.start()
	yield(tween, 'tween_complete')
	charger.can_charge = true

func end_game(pos, texture):
	var fader = FADER.instance()
	fader.fade_out_time = 4
	var sprite = Sprite.new()
	sprite.set_texture(texture)
	add_child(sprite)
	sprite.set_modulate(Color(.5, 0, 0))
	sprite.set_pos(pos)
	current_room.hide()
	get_node("HUD").free()
	self.add_child(fader)
	fader.fade_out()
	yield(fader, "faded_out")
	get_tree().change_scene(GAMEOVER_PATH)
