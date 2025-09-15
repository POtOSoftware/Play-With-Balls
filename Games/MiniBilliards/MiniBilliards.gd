extends Node2D

onready var cue_ball: Node = $CueBall
onready var holes_parent: Node = $Holes

var hole_scene: PackedScene = preload("res://Assets/Hole/Hole.tscn")
var ball_arrangement_scene: PackedScene = preload("res://Assets/BallArrangement/BallArrangement.tscn")

func _ready() -> void:
	_place_holes(3)
	#cue_ball.apply_impulse(Vector2(0,0), Vector2(-500, 0))

func _place_holes(num_of_holes: int = 1):
	for current_hole in num_of_holes:
		var hole_instance = hole_scene.instance()
		
		hole_instance.spawn()
		
		holes_parent.add_child(hole_instance)
