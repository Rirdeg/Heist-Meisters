extends ColorRect



func _on_Area2D_body_entered(body):
	if body.has_node("briefcase"):
		print("You have the briefcase and succsfully escaped the office")
