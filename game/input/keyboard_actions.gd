
extends Node2D

const ACTS = preload("res://definitions/actions.gd")

signal pressing_act(act)

func _ready():
	set_fixed_process(true)

#func _fixed_process(dt):
 # var dir = DIRS.NONE
 # if Input.is_action_pressed("ui_right"):
   # dir += DIRS.RIGHT
 # if Input.is_action_pressed("ui_left"):
  #  dir += DIRS.LEFT
  #emit_signal("pressing_dir", dir)
