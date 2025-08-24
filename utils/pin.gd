extends Node

func get_dpad() -> Vector2i:
	return Vector2i(
		1 if Input.is_action_pressed("right") else 0 -
		1 if Input.is_action_pressed("left") else 0,
		1 if Input.is_action_pressed("down") else 0 -
		1 if Input.is_action_pressed("up") else 0
	)
func get_dpad_hit() -> Vector2i:
	return Vector2i(
		1 if Input.is_action_just_pressed("right") else 0 -
		1 if Input.is_action_just_pressed("left") else 0,
		1 if Input.is_action_just_pressed("down") else 0 -
		1 if Input.is_action_just_pressed("up") else 0
	)

func get_a() -> bool:
	return Input.is_action_pressed("action")
func get_a_hit() -> bool:
	return Input.is_action_just_pressed("action")
func get_b() -> bool:
	return Input.is_action_pressed("cancel")
func get_b_hit() -> bool:
	return Input.is_action_just_pressed("cancel")
