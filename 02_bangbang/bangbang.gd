extends Node2D

func _ready() -> void:
	for i in range(10):
		var newshape = $Shape.duplicate()
		add_child(newshape)

func _physics_process(_delta: float) -> void:
	var distsqr2nearest = 99999;
	var nearestshape : Node2D = null;
	for child in get_children():
		if child.name.begins_with("Camera2D"):
			pass
		else:
			var distsqr = (child.position as Vector2).distance_squared_to(get_global_mouse_position())
			if distsqr < distsqr2nearest:
				distsqr2nearest = distsqr
				nearestshape = child as Node2D
	if nearestshape:
		nearestshape.struck = 3
		print(nearestshape.name)

func get_nearest_target(aimer : Node2D) -> Node2D:
	for child in get_children():
		if child != aimer: return child
	return null
