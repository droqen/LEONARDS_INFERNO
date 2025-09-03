extends Node2D

var _hp : float = 1.0
var hp : float :
	get : return _hp
	set(v) :
		if v <= 0:
			v = 0
			queue_free()
		_hp = v
		$hpscaler.scale.x = _hp
var vel : Vector2
var bounds_size : int = 400

func _ready() -> void:
	if randf() < 0.5:
		position.x = bounds_size*sign(randf()-0.5)
		position.y = randf_range(-1,1)*bounds_size
	else:
		position.y = bounds_size*sign(randf()-0.5)
		position.x = randf_range(-1,1)*bounds_size
	vel = Vector2.RIGHT.rotated(PI*randf()*2) * randf_range(1.0,2.0)
func _physics_process(_delta: float) -> void:
	position += vel
	if vel.x<0 and position.x<-bounds_size:vel.x*=-1
	if vel.x>0 and position.x> bounds_size:vel.x*=-1
	if vel.y<0 and position.y<-bounds_size:vel.y*=-1
	if vel.y>0 and position.y> bounds_size:vel.y*=-1
