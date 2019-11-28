extends "res://Scripts/Character.gd"

var motion = Vector2()
enum VISION_MODE {DARK, NIGHTVISION}
var vision_mode = VISION_MODE.DARK

var disguised = false

#VisionMode timer variables
var cooldown = 2
var is_cooldown_ready = true


func _ready():
	Global.Player = self
	$VisionModeTimer.wait_time = cooldown
	


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

func _input(event):
	if Input.is_action_just_pressed("ui_vision_mode_change"):
		cycle_vision_mode()
	if Input.is_action_just_pressed("toggle_disguise"):
		toggle_disguise()

func cycle_vision_mode():
	if is_cooldown_ready == true:
		is_cooldown_ready = false
		$VisionModeTimer.start()
		get_tree().call_group("ui_labels", "toggle_labels")
		if vision_mode == VISION_MODE.DARK:
			get_tree().call_group("interface", "NV_mode")
			vision_mode = VISION_MODE.NIGHTVISION
		elif vision_mode == VISION_MODE.NIGHTVISION:
			get_tree().call_group("interface", "DarkVision_mode")
			vision_mode = VISION_MODE.DARK



func _on_VisionModeTimer_timeout():
	$VisionModeTimer.stop()
	is_cooldown_ready = true


func reveal():
	$Sprite.texture = load(Global.player_sprite)
	$Light2D.texture = load(Global.player_sprite)
	$LightOccluder2D.occluder = load(Global.character_occluder)
	collision_layer = 1
	disguised = false


func disguise():
	$Sprite.texture = load(Global.box_sprite)
	$Light2D.texture = load(Global.box_sprite)
	$LightOccluder2D.occluder = load(Global.box_occluder)
	collision_layer = 16
	disguised = true


func toggle_disguise():
	if disguised:
		reveal()
	else:
		disguise()


