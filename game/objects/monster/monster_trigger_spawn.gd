extends Area2D

const CHARACTER = preload("res://objects/character/character.gd")
const FLICKERING = preload("res://objects/monster/flickering_monster.tscn")
const CRAWLER = preload("res://objects/monster/crawler.tscn")

export(int) var monster_type

signal triggered

func _ready():
	for shape in get_children():
		add_shape(shape.get_shape())
	yield(get_tree(), "fixed_frame")
	connect("body_enter", self, "_check_character")

func _check_character(body):
	if body extends CHARACTER:
		spawn(body)



func spawn(character):
	var monster
	if (monster_type == 1):
		monster = FLICKERING.instance()
	if (monster_type == 2):
		monster = CRAWLER.instance()
	monster.character = character
	monster.set_pos(get_pos() + Vector2(-900,0))
	get_parent().add_child(monster)
	queue_free()

