extends "res://Scripts/Door.gd"

var combination 
var combination_entered = false

func _input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and is_in_player_range and not combination_entered:
		$CanvasLayer/NumberPad.popup_centered()
	elif Input.is_mouse_button_pressed(BUTTON_LEFT) and is_in_player_range and combination_entered:
		open()

func _on_Door_body_exited(body):
	$CanvasLayer/NumberPad.hide()
	$CanvasLayer/NumberPad.reset_lock()


func _on_NumberPad_combination_correct():
	open()
	combination_entered = true


func _on_Computer_combination(numbers, lock_group):
	combination = numbers
	$CanvasLayer/NumberPad.combination = combination
	$Label.rect_rotation = -rotation_degrees
	$Label.text = lock_group
