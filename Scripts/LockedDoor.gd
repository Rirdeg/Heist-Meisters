extends "res://Scripts/Door.gd"

func _input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and is_in_player_range:
		$CanvasLayer/NumberPad.popup_centered()

func _on_Door_body_exited(body):
	$CanvasLayer/NumberPad.hide()
