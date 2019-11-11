extends CanvasLayer

onready var player = get_node("Player")

func _process(delta):
	$Label.text = "Movement Vector: " + str(get_parent().get_node("Player").motion)
	$Label2.text = "Lookat Vector: " + str(get_parent().get_global_mouse_position())
	$Label3.text = "World Position: " + str(get_parent().get_node("Player").position)
	$Label4.text = "Vision Cooldown: " + str(get_parent().get_node("Player").get_node("VisionModeTimer").time_left)
