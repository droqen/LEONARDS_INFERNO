extends Node2D

const BULLET_PFB = preload("res://04_weave/bullet.tscn")

func _ready() -> void:
	for i in range(100):
		spawn_bullet(Vector2(randf()*1000,randf()*1000),Vector2(randf()*1000,randf()*1000),randf_range(1.0,2.0))

func spawn_bullet(pos,targ,spd):
	var bullet = BULLET_PFB.instantiate()
	bullet.position = pos
	bullet.vel = (targ-pos).normalized() * spd
	add_child(bullet)
	bullet.owner = owner if owner else self
