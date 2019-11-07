extends "res://Scripts/Character.gd"

var motion = Vector2()


func _ready():
	Global.Player = self


func _process(delta):
	update_motion()
	move_and_slide(motion)

func update_motion():
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("move_up") and not Input.is_action_pressed("move_down"):
		motion.y = clamp((motion.y - SPEED), -MAX_SPEED, 0)
	elif Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_up"):
		motion.y = clamp((motion.y + SPEED), 0, MAX_SPEED)
	else:
		motion.y = lerp(motion.y, 0, FRICTION)
	
	if Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		motion.x = clamp((motion.x - SPEED), -MAX_SPEED, 0)
	elif Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		motion.x = clamp((motion.x + SPEED), 0, MAX_SPEED)
	else:
		motion.x = lerp(motion.x, 0, FRICTION)
