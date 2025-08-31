extends Node2D

var GAMEMETA = load("res://05_dreamer_splash/01_gamemeta/dream_gamemeta.tres")

var _currency : int
var currency : int :
	get : return _currency
	set(c) :
		Dreamer.w('currency', c, GAMEMETA)
		_currency = c

@onready var difficulty : int = Dreamer.r('gameplay difficulty') # doesn't change

func _ready() -> void:
	_currency = Dreamer.r('currency')
	var difficulty : int = Dreamer.r('gameplay difficulty')

func _physics_process(_delta: float) -> void:
	$Label.text = "This is Gameplay, difficulty %d\nYou have $%d.\nPress ENTER to finish" % [difficulty, currency]
	var dphy = Pin.get_dpad_hit().y
	if dphy: currency -= dphy
	if Pin.get_a_hit():
		Dreamer.wake()
