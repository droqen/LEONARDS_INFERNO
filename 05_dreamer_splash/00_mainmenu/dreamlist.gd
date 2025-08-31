extends Node2D

@onready var dreams : Array[NavdiDream] = [
	load("res://05_dreamer_splash/01_gamemeta/dream_gamemeta.tres")
]

func _physics_process(_delta: float) -> void:
	$Label.text = "\n"
	for dream in dreams:
		$Label.text += "%s\n"%dream
	$Label.text = $Label.text.trim_prefix("\n").trim_suffix("\n")
	if Pin.get_a_hit():
		Dreamer.dream(dreams[0])
