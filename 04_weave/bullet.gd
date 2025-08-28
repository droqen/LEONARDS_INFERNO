extends Node2D

var vel : Vector2
var windowsize : Vector2
func _ready() -> void:
	windowsize = get_viewport_rect().size
func _physics_process(_delta: float) -> void:
	position += vel
	if position.x < 0 and vel.x < 0: vel.x *= -1
	if position.x > windowsize.x and vel.x > 0: vel.x *= -1
	if position.y < 0 and vel.y < 0: vel.y *= -1
	if position.y > windowsize.y and vel.y > 0: vel.y *= -1
