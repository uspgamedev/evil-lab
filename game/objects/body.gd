
extends KinematicBody2D

const DIR = preload("res://definitions/directions.gd")
const ACT = preload("res://definitions/actions.gd")
const CONST = preload("res://definitions/constants.gd")

const DEFAULT_ACC = 32.0 * 10
const DEACC = 0.75
const SPEEDLIMIT = DEFAULT_ACC * 5

signal speed_changed(speed)

onready var speed = Vector2()
var ACC = DEFAULT_ACC

func _ready():
  set_fixed_process(true)

func _fixed_process(delta):
    pvt_apply_speed(delta)
    pvt_apply_speedlimit(delta)
    if ACC > 0:
        emit_signal("speed_changed", speed)

func push_dir(dir):
    push(DIR.dir2vec(dir))

func push(dir_vec):
    self.speed += dir_vec * ACC
    if ACC > 0:
        emit_signal("speed_changed", speed)

func pvt_apply_speed(delta):
  if self.speed.length_squared() <= CONST.EPSILON*CONST.EPSILON:
    return
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
