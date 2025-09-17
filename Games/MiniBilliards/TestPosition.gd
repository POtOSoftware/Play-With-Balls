extends Area2D

signal position_okay

func test_position(new_position: Vector2) -> bool:
	position = new_position
	
	yield(get_tree(), "physics_frame")
	
	if get_overlapping_areas() != null:
		return false
	else:
		return true
