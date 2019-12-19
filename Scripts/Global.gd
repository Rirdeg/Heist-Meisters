extends Node

var Player
var navigation
var destination


#Asset Links - MUST BE CHANGED MANUALLY
var nightvision_on_sfx = "res://SFX/nightvision.wav"
var nightvision_off_sfx = "res://SFX/nightvision_off.wav"

var green_light = "res://GFX/Interface/PNG/dotGreen.png"
var red_light = "res://GFX/Interface/PNG/dotRed.png"

var box_sprite = "res://GFX/PNG/Tiles/tile_129.png"
var player_sprite = "res://GFX/PNG/Hitman 1/hitman1_stand.png"
var briefcase_sprite = "res://GFX/Loot/suitcase.png"

var character_occluder = "res://characterlightoccluder.tres"
var box_occluder = "res://boxlightoccluder.tres"