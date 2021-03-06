extends "res://Scripts/Character.gd"

export var num_disguises = 3 #Starting number of disguises
export var disguise_duration = 5 #Time in secs the disguise will last
export var disguise_slowdown = 0.25

var has_briefcase = false

var motion = Vector2()
enum VISION_MODE {DARK, NIGHTVISION}
var vision_mode = VISION_MODE.DARK

var disguised = false
var velocity_multiplyer = 1

#VisionMode timer variables
var cooldown = 1.2
var is_cooldown_ready = true


func _ready():
	Global.Player = self
	$VisionModeTimer.wait_time = cooldown
	$Timer.wait_time = disguise_duration
	reveal()
	update_disguise_display()
	


func _process(delta):
	update_motion()
	move_and_slide(motion * velocity_multiplyer)
	if disguised:
		$Label.rect_rotation = -rotation_degrees
		$Label.text = str($Timer.time_left).pad_decimals(2)

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
	$Label.visible = false
	$Sprite.texture = load(Global.player_sprite)
	$Light2D.texture = load(Global.player_sprite)
	$LightOccluder2D.occluder = load(Global.character_occluder)
	collision_layer = 1
	velocity_multiplyer = 1
	disguised = false


func disguise():
	$Label.visible = true
	$Sprite.texture = load(Global.box_sprite)
	$Light2D.texture = load(Global.box_sprite)
	$LightOccluder2D.occluder = load(Global.box_occluder)
	
	velocity_multiplyer = disguise_slowdown
	$Timer.start()
	num_disguises -= 1
	update_disguise_display()
	
	collision_layer = 16
	disguised = true


func toggle_disguise():
	if disguised:
		reveal()
	elif num_disguises > 0:
		disguise()


func update_disguise_display():
	get_tree().call_group("DisguiseDisplay", "update_disguises", num_disguises)


func collect_loot():
	var loot = Node.new()
	loot.set_name("briefcase")
	add_child(loot)
	get_tree().call_group("loot_container", "collect_loot")