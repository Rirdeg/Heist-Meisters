extends Popup

onready var display = $VSplitContainer/DisplayContainer/Display
onready var light = $VSplitContainer/ButtonContainer/ButtonGrid/Light

var combination = [2,1,4,6]
var guess = []


func _ready():
	connect_buttons()
	reset_lock()


func connect_buttons():
	for button in $VSplitContainer/ButtonContainer/ButtonGrid.get_children():
		if button is Button:
			button.connect("pressed", self, "_on_Button_pressed", [button.text])


func _on_Button_pressed(button):
	if button == "OK":
		check_guess()
	else:
		enter(int(button))


func check_guess():
	if guess == combination:
		$Timer.start()
		light.texture = load(Global.green_light)
	else:
		reset_lock()


func enter(num):
	guess.append(num)
	update_display()


func reset_lock():
	light.texture = load(Global.red_light)
	display.clear()
	guess.clear()


func update_display():
	display.bbcode_text = "[center]" + PoolStringArray(guess).join("") + "[/center]"
	if guess.size() >= combination.size():
		check_guess()


func _on_Timer_timeout():
	hide()
	reset_lock()






