extends Node

const FLICK_MONSTER = preload('res://objects/monster/flickering_monster.tscn')
const CRAWLER = preload('res://objects/monster/crawler.tscn')

export (NodePath) var character

onready var main = get_parent()
var spawn_on = false

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if (character.light_battery <= character.MIN_BATTERY + character.MAX_BATTERY/5 and !spawn_on):
		spawn_on = true
		for i in character.get_parent().get_children():
			if (i.get_name() == "SpawnRange"):
				if (randf() >= 0.8):
					var flick_monster = FLICK_MONSTER.instance()
					var pos
					while(true):
						pos = i.minimum + randf()*i.maximum
						if (abs(pos - character.get_pos().x) > 300):
							break
					flick_monster.set_pos(Vector2(pos, 0))
					flick_monster.character = character
					character.get_parent().add_child(flick_monster)
	elif (character.light_battery > character.MIN_BATTERY + character.MAX_BATTERY/5):
		spawn_on = false
	