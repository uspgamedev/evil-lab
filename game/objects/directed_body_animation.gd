
extends AnimationPlayer

const DIRS = preload("res://definitions/directions.gd")
const CONST = preload("res://definitions/constants.gd")

var last_dir = "left_"

func track_movement(speed):
	var dir = DIRS.vec2dir(speed)
	var anim_type
	if dir == DIRS.NONE:
		anim_type = "idle"
	else:
		if speed.length_squared() > CONST.EPSILON*CONST.EPSILON:
			anim_type = "moving"
		else:
			anim_type = "idle"
	dir = pvt_dirface(dir)
	self.last_dir = pvt_dirname(dir)
	var anim = last_dir + anim_type
	if get_current_animation() != anim:
		play(anim)

func pvt_dirface(dir):
  if dir == DIRS.UP:
    return DIRS.UP
  elif dir == DIRS.RIGHT:
    return DIRS.RIGHT
  elif dir == DIRS.DOWN:
    return DIRS.DOWN
  elif dir == DIRS.LEFT:
    return DIRS.LEFT
  elif dir == DIRS.UP_RIGHT:
    return DIRS.RIGHT
  elif dir == DIRS.DOWN_RIGHT:
    return DIRS.RIGHT
  elif dir == DIRS.DOWN_LEFT:
    return DIRS.LEFT
  elif dir == DIRS.UP_LEFT:
    return DIRS.LEFT

func pvt_dirname(dir):
  if dir == DIRS.UP:
      return "up_"
  elif dir == DIRS.RIGHT:
      return "right_"
  elif dir == DIRS.DOWN:
      return "down_"
  elif dir == DIRS.LEFT:
      return "left_"
  else:
      return last_dir
