extends Node2D

var  vel  :  Vector2

enum { FLORBUF, JUMPBUF, }

@onready var spr = $spr
@onready var mover = $mover
@onready var solidcast = $mover/solidcast
@onready var bufs = Bufs.Make(self).setup_bufons([
	FLORBUF, 5, JUMPBUF, 5,
])

func _physics_process(_delta: float) -> void:
	var dpad = Pin.get_dpad()
	var jumpheld : bool = Pin.get_a() or dpad.y < 0
	var jumphit : bool = Pin.get_a_hit() or Pin.get_dpad_hit().y < 0
	if mover.cast_fraction(self, solidcast, HORIZONTAL, -3) < 1:
		position.x += 0.25
		if vel.x < 0: vel.x = 0
	if mover.cast_fraction(self, solidcast, HORIZONTAL, 3) < 1:
		position.x -= 0.25
		if vel.x > 0: vel.x = 0
	vel.x = lerp(vel.x, dpad.x*1., 0.25)
	#vel.y = lerp(vel.y, dpad.y*1., 0.25)
	var onfloor : bool = vel.y >= 0 and mover.cast_fraction(self, solidcast, VERTICAL, 1) < 1
	if onfloor : bufs.on(FLORBUF)
	if jumphit: bufs.on(JUMPBUF)
	if bufs.try_eat([FLORBUF, JUMPBUF]): vel.y = -2.0; onfloor = false;
	else:
		vel.y += 0.05
		if vel.y < 0 and not jumpheld:
			vel.y += 0.10
		
	if !mover.try_slip_move(self, solidcast, HORIZONTAL, vel.x):
		vel.x = 0
	if !mover.try_slip_move(self, solidcast, VERTICAL, vel.y):
		vel.y = 0
