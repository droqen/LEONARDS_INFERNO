extends Node2D
var spawnspeed : float = 1.0
var spawn_charge : float = 0.0
var fastspawn : int = 40

func _physics_process(delta: float) -> void:
	if fastspawn > 0:
		spawn_charge += fastspawn * spawnspeed * delta
	else:
		spawn_charge += spawnspeed * delta
		spawnspeed *= 1.0 + 0.1 * delta
	
	while spawn_charge >= 1:
		$Bank.spawn("disc")
		spawn_charge -= 1
		if fastspawn > 0:
			fastspawn -= 1
