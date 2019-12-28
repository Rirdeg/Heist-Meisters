extends Node2D

var text

func _ready():
	text = get_json()
	update_pointer_position(0)
	$TutorialGUI/Popup.show()

func get_json():
	var file = File.new()
	file.open(Global.tutorial_messages, file.READ)
	var content = file.get_as_text()
	file.close()
	return parse_json(content)


func update_pointer_position(number):
	var pointer = $ObjectivePointer
	var marker = $ObjectiveMarkers.get_child(number)
	$Tween.interpolate_property(pointer,"position",pointer.position,marker.position,
			0.5,Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()
	$AudioStreamPlayer.play()
	$TutorialGUI/AnimationPlayer.play("MessageTransition")
	yield(get_tree().create_timer(0.35), "timeout")
	$TutorialGUI/Popup/Label.text = text[str(number)]

func _on_ObjectiveMove_body_entered(body):
	update_pointer_position(1)


func _on_ObjectiveDoor_body_entered(body):
	update_pointer_position(2)


func _on_ObjectiveBriefcase_body_entered(body):
	update_pointer_position(3)


func _on_Briefcase_body_entered(body):
	update_pointer_position(4)


func _on_ObjectiveCamera_body_entered(body):
	update_pointer_position(5)
