extends Node

func _physics_process(_delta: float) -> void:
	var maze : Maze = get_parent()
	if randf() < 0.1:
		var cells = maze.get_used_cells()
		var i = randi() % len(cells)
		maze.set_cell_tid(cells[i],randi()%4)
