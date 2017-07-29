
extends Node2D

const ACT = preload("res://definitions/actions.gd")

signal pressing_act(act)

func _ready():
	set_process_input(true)

func _input(event):
  var act = ACT.NONE
  if event.is_action_pressed("ui_light"):
    act = ACT.LIGHT
  if event.is_action_pressed("ui_reload"):
    act = ACT.RELOAD
  if event.is_action_pressed("ui_interact"):
    act = ACT.INTERACT
  emit_signal("pressing_act", act)
