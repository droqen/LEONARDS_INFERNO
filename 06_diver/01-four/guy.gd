extends Node2D

enum { JUMPBUF, FLORBUF }
@onready var bufs : Bufs = Bufs.Make(self).setup_bufons(
	[ JUMPBUF,  4, FLORBUF, 4, ]
)
@onready var mover : NavdiBodyMover = $mover
@onready var caster = $mover/ShapeCast2D
@onready var spr : SheetSprite = $SheetSprite
var vx : float ; var vy : float;
var just_jumped : bool = false;
var air_maneuverability : float = 0.0;
var jet_phase : float = 0.0
func _physics_process(_delta: float) -> void:
	var dpad = Pin.get_dpad()
	var jumphit : bool = Pin.get_a_hit() or Pin.get_dpad_hit().y < 0
	var jumpheld : bool = Pin.get_a() or dpad.y < 0
	var onfloor : bool = vy >= 0 and mover.cast_fraction(self,caster,VERTICAL,1)<1
	if onfloor: bufs.on(FLORBUF); just_jumped = false;
	if vx : spr.flip_h = vx < 0
	if jumphit: bufs.on(JUMPBUF); just_jumped = false;
	if bufs.try_eat([JUMPBUF,FLORBUF]):
		onfloor = false
		vy = -1.3
		just_jumped = true
		air_maneuverability *= 2
	
	if jumpheld and (not just_jumped or vy > 0):
		just_jumped = false
		jet_phase += 0.15
		vy = move_toward(vy, -0.5 -0.2 * sin(jet_phase), 0.03)
		if vy < 0:
			air_maneuverability = move_toward(air_maneuverability, 1.0, 0.03)
	else:
		jet_phase = 0.0
		if vy < 0:
			vy = move_toward(vy,  0.0, 0.04 if jumpheld else 0.1)
		else:
			vy = move_toward(vy,  2.0, 0.05)
		air_maneuverability = move_toward(air_maneuverability, 0.0, 0.01)
	
	vx = move_toward(vx,
		dpad.x * lerp(0.6, 1.0, air_maneuverability),
		lerp(0.2, 0.1, air_maneuverability))
	
	if!mover.try_slip_move(self,caster,HORIZONTAL,vx):
		vx=0
	if!mover.try_slip_move(self,caster,VERTICAL,vy):
		vy=0
