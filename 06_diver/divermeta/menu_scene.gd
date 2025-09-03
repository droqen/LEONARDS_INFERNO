extends Node2D

var MENUITEMS = [
	["New Game", func(): Dreamer.dream(null)],
	["Quit", func(): get_tree().quit(0)],
]

var menuidx : int = 0

func _ready() -> void:
	relabel()
func _physics_process(_delta: float) -> void:
	var dy = Pin.get_dpad_hit().y
	if dy:
		menuidx = posmod(menuidx + dy, len(MENUITEMS))
		relabel()
	if Pin.get_a_hit():
		MENUITEMS[menuidx][1].call()
func relabel() -> void:
	$Label.text = ""
	for i in range(len(MENUITEMS)):
		$Label.text += "%s%s%s\n" % [
			"[" if (menuidx==i) else " ", 
			MENUITEMS[i][0],
			"]" if (menuidx==i) else " ", 
		]
