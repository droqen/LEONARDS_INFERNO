@tool
extends Node2D

const TRIPOINTS : PackedVector2Array = [
	Vector2(6,-10),
	Vector2(6,10),
	Vector2(-11,0),
]
const TRIPOINTS_WRAP : PackedVector2Array = [
	Vector2(6,-10),
	Vector2(6,10),
	Vector2(-11,0),
	Vector2(6,-10),
]
const TRICOLORS : PackedColorArray = [
	Color.WHITE,
	Color.WHITE,
	Color.WHITE,
]

var struck : int = 0

var vel : Vector2
var angvel : float
func _ready() -> void:
	position.x = randf_range(-100,100)
	position.y = randf_range(-50,50)
	vel.x = randf() - 0.5
	vel.y = randf() - 0.5
	angvel = randf() - 0.5

func _physics_process(_delta: float) -> void:
	position += vel
	rotation += angvel * 0.01
	if position.x > 100 and vel.x > 0: vel.x *=-1; angvel *=-1;
	if position.y >  50 and vel.y > 0: vel.y *=-1; angvel *=-1;
	if position.x <-100 and vel.x < 0: vel.x *=-1; angvel *=-1;
	if position.y < -50 and vel.y < 0: vel.y *=-1; angvel *=-1;
	
	if struck > 0:
		struck -= 1
		queue_redraw()

func _draw() -> void:
	if struck > 0:
		draw_polygon(TRIPOINTS, TRICOLORS)
	draw_polyline(TRIPOINTS_WRAP, Color.WHITE, 2, true)
