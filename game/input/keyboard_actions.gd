
extends Node2D

const ACT = preload("res://definitions/actions.gd")

signal pressing_act(act)

func _ready():
	set_fixed_process(true)

func _fixed_process(dt):
  var act = ACT.NONE
  if Input.is_action_pressed("ui_light"):
    act += ACT.LIGHT
  if Input.is_action_pressed("ui_reload"):
    act += ACT.RELOAD
  if Input.is_action_pressed("ui_interact"):
    act += ACT.INTERACT
  emit_signal("pressing_act", act)
