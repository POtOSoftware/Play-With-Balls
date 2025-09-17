extends Node2D

onready var cue_ball: Node = $CueBall
onready var holes_parent: Node = $Holes
onready var hole_exclusion_zone: Node = $HoleExclusionZone
onready var test_hole: Node = $Holes/TestPosition

var hole_scene: PackedScene = preload("res://Assets/Hole/Hole.tscn")
var ball_arrangement_scene: PackedScene = preload("res://Assets/BallArrangement/BallArrangement.tscn")

var test_in_exclusion_zone: bool = true
var test_hole_passed: bool = false

const MIN_COORDINATE: Vector2 = Vector2(16, 16)
const MAX_COORDINATE: Vector2 = Vector2(304, 168)

func _ready() -> void:
	_place_holes(3)
	#cue_ball.apply_impulse(Vector2(0,0), Vector2(-500, 0))

func _place_holes(num_of_holes: int):
	for current_hole in num_of_holes:
		var hole_instance = hole_scene.instance()
		
		# i use an invisible area2d node because sometimes the ball still gets eaten 
		# if the hole spawns inside the exclusion zone before moving. so just place
		# a totally neutral object somewhere, and if it's not in the exclusion zone
		# spawn a hole there. if it is in the zone, generate new coords and run the
		# check again
		
		var spawn_position = _generate_random_spawn_position()
		
		var space_state = get_world_2d().direct_space_state
		var in_exclusion_zone = space_state.intersect_point(spawn_position, 32 , [] , 0x7FFFFFFF, true, true)
		
		print(in_exclusion_zone)
		
		if in_exclusion_zone:
			while in_exclusion_zone:
				in_exclusion_zone = space_state.intersect_point(_generate_random_spawn_position())
		
		hole_instance.spawn(spawn_position)
		
		holes_parent.add_child(hole_instance)

func _generate_random_spawn_position() -> Vector2:
	var rand_pos_x: float = GameManager.rng.randi_range(MIN_COORDINATE.x, MAX_COORDINATE.x)
	var rand_pos_y: float = GameManager.rng.randi_range(MIN_COORDINATE.y, MAX_COORDINATE.y)
	
	return Vector2(rand_pos_x, rand_pos_y)

func _test_hole_spawn_position(test_position: Vector2) -> Vector2:
	yield(get_tree(), "physics_frame")
	test_hole.position = test_position
	yield(get_tree(), "physics_frame")
	
	if test_hole.overlaps_area(hole_exclusion_zone):
		print("Spawn position X: %f | Y: %f was inside exclusion zone! Regenerating coordinates..." % [test_position.x, test_position.y])
		_test_hole_spawn_position(_generate_random_spawn_position())
	
	return test_position
