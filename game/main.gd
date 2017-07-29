extends Node2D

const CHARACTER = preload("res://objects/character/character.tscn")

onready var character = CHARACTER.instance()

export(PackedScene) var first_room

onready var rooms = {}

func _ready():
	pass

func _load_room(name):
	pass
