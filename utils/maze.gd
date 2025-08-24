extends TileMapLayer
class_name Maze

func get_cell_tid(coords:Vector2i) -> int:
	return atlas_coords_to_tid(get_cell_atlas_coords(coords))
func set_cell_tid(coords:Vector2i,tid:int) -> void:
	set_cell(coords, 0, tid_to_atlas_coords(tid))
func tid_to_atlas_coords(tid:int) -> Vector2i:
	return Vector2i(tid % 10, tid / 10)
func atlas_coords_to_tid(atlas_coords : Vector2i) -> int:
	return atlas_coords.x + atlas_coords.y * 10
