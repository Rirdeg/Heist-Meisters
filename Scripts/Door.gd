extends Area2D

var is_in_player_range = false

<<<<<<< Updated upstream
=======
# ------------------------------------------------- #
# Would like to make door stay upon when character is infront of it
# idea to emove animation player and lerp() the position of the sprite through code
# This would fix guards getting stuck on doors or doors not opening when they stay within the bounds
#-------------------------------------------------- #

>>>>>>> Stashed changes
func _on_Door_body_entered(body):
	if not body == Global.Player and not $AnimationPlayer.is_playing():
		open()
	else:
		is_in_player_range = true
		


func _on_Door_body_exited(body):
	if body == Global.Player:
		is_in_player_range = false


func open():
	$AnimationPlayer.play("open")
	

func _input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and is_in_player_range:
		open()