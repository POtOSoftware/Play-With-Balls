extends Node2D

onready var cue_ball: Node = $CueBall
onready var holes_parent: Node = $Holes

const MIN_COORDINATE: Vector2 = Vector2(16, 16)
const MAX_COORDINATE: Vector2 = Vector2(304, 168)

var hole_scene: PackedScene = preload("res://Assets/Hole/Hole.tscn")
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	
	_place_holes(3)
	#cue_ball.apply_impulse(Vector2(0,0), Vector2(-500, 0))

func _place_holes(num_of_holes: int = 1):
	for current_hole in num_of_holes:
		var hole_instance = hole_scene.instance()
		
		hole_instance.position.x = rng.randi_range(MIN_COORDINATE.x, MAX_COORDINATE.x)
		hole_instance.position.y = rng.randi_range(MIN_COORDINATE.y, MAX_COORDINATE.y)
		
		holes_parent.add_child(hole_instance)
