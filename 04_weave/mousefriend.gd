extends Node2D
var vel : Vector2
var angvel : float
var rot : float
var focus : bool = false
const MOUSEDIST =     [ 0, 10, 50, 100, 9999999]
const MOVERVEL =      [ 0,  3, 20,  30,      30]
const FOCUSMOVERVEL = [ 0,  3,  6,  10,      10]

func _physics_process(_delta: float) -> void:
	if focus != Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		focus = not focus
		if focus: Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		else: Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	var m = get_global_mouse_position()
	var target_vel : Vector2 = Vector2.ZERO
	var tom = m - global_position
	var tomlen = tom.length()
	if tomlen > .0001:
		var tomdir = tom / tomlen
		var movervel = FOCUSMOVERVEL if focus else MOVERVEL
		for i in range(1, len(MOUSEDIST)):
			if tomlen < MOUSEDIST[i]:
				target_vel = tomdir * remap(tomlen, MOUSEDIST[i-1], MOUSEDIST[i], movervel[i-1], movervel[i])
				break
	vel = target_vel
	position += vel
	#var m = get_global_mouse_position()
	#var tom = m - global_position
	#var tomlen = tom.length()
	#var tomdir = tom / tomlen
	#if tomlen < 20.0:
		#tomlen = max(0,remap(tomlen,10,20,0,20))
	#tomlen = lerp(0.0, 15.0, clampf(inverse_lerp(15,100,tomlen),0,1))
	#var targetvel = (tomdir*tomlen)
	#global_position += targetvel
	var target_rot = vel.x * 0.01
	var target_angvel = target_rot - rot
	angvel = lerp(angvel * 0.95, target_angvel, 0.05)
	rot += angvel
	rotation = rot
	modulate = lerp(modulate,Color.WHITE,0.1)
	if focus:
		self_modulate = lerp(self_modulate, Color.DIM_GRAY, 0.3)
		$focus.modulate.a = lerp($focus.modulate.a, 1.0, 0.1)
	else:
		self_modulate = lerp(modulate,Color.WHITE,0.1)
		$focus.modulate.a = lerp($focus.modulate.a, 0.0, 0.1)

func _on_hitbox_area_entered(area: Area2D) -> void:
	area.get_parent().queue_free()
	modulate = Color.RED
