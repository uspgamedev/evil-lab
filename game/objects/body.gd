
extends KinematicBody2D

const DIR = preload("res://definitions/directions.gd")
const ACT = preload("res://definitions/actions.gd")
const CONST = preload("res://definitions/constants.gd")

const ACC = 32
const DEACC = 0.75
const SPEEDLIMIT = ACC * 5

signal speed_changed(speed)

var speed = Vector2()
var can_charge = false

onready var animation = get_node("Sprite/Animation")

func _ready():
  set_fixed_process(true)

func _fixed_process(delta):
    pvt_apply_speed(delta)
    pvt_apply_speedlimit(delta)
    emit_signal("speed_changed", speed)

func push_dir(dir):
    push(DIR.dir2vec(dir))

func push(dir_vec):
    self.speed += dir_vec * ACC
    emit_signal("speed_changed", speed)

func pvt_apply_speed(delta):
  var motion_scale = self.speed * delta
  var motion = move(motion_scale)
  if is_colliding():
    var collider = get_collider()
    var normal = get_collision_normal()
    motion = normal.slide(motion)
    self.speed = normal.slide(self.speed)
    move(motion)

func pvt_apply_speedlimit(delta):
  self.speed *= DEACC
  if self.speed.length_squared() <= CONST.EPSILON*CONST.EPSILON:
    self.speed.x = 0
    self.speed.y = 0

func _pressing_act(act):
	if (act == ACT.LIGHT):
		if (self.get_node("Light2D").is_hidden()):
			self.get_node("Light2D").show()
		else:
			self.get_node("Light2D").hide()
	if (act == ACT.RELOAD):
		pass
	if (act == ACT.INTERACT):
		if (can_charge):
			print('you can charge')
		else:
			print('you can not charge')

func enable_charging():
	can_charge = true

func disable_charging():
	can_charge = false
