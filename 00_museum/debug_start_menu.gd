extends Node2D

@export var scenes : Array[PackedScene]

var scenenames : Array[String] = []

var cursor : int = 0

func _ready() -> void:
	for scene in scenes:
		scenenames.append(
			scene.resource_path.rsplit("/",true,1)[1].split(".")[0]
		)

func _physics_process(_delta: float) -> void:
	var dpad = Pin.get_dpad_hit()
	if dpad.y:
		cursor = posmod(cursor + dpad.y, len(scenes))
	var label = $Label; label.text = ""
	for i in range(len(scenes)):
		label.text += "%s%s%s\n" % [
			"[" if i == cursor else " ",
			scenenames[i],
			"]" if i == cursor else " ",
		]
	if Pin.get_a_hit():
		get_tree().change_scene_to_packed(scenes[cursor])
