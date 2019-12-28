extends CanvasModulate

const DARK = Color("08090f")
const NIGHTVISION = Color("2dad29")

func _ready():
	visible = true
	color = DARK
	add_to_group("interface")
	get_tree().call_group("ui_labels", "hide")


func NV_mode():
	inform_npcs("NV_mode")
	color = NIGHTVISION
	$AudioStreamPlayer2D.stream = load(Global.nightvision_on_sfx)
	play_sfx()
	get_tree().call_group("ui_labels", "show")


func DarkVision_mode():
	inform_npcs("DarkVision_mode")
	color = DARK
	$AudioStreamPlayer2D.stream = load(Global.nightvision_off_sfx)
	play_sfx()
	get_tree().call_group("ui_labels", "hide")


func play_sfx():
	$AudioStreamPlayer2D.play()


func inform_npcs(vision_mode):
	get_tree().call_group("npc", vision_mode)