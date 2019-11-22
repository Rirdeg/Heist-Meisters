extends TextureProgress

var suspicion = 0

#This is how much suspicion goes up everytime we are seen
export var suspicion_step = 1
#How fast suspicion falls
export var suspicion_dropoff = 0.25


func _process(delta):
	suspicion -= suspicion_dropoff
	suspicion = clamp(suspicion, 0, max_value)
	value = suspicion
	print(suspicion)



func player_seen():
	if suspicion == max_value:
		end_game()
	suspicion += suspicion_step


func end_game():
	get_tree().quit()
