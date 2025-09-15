extends Node

enum ball_types {CUE_BALL, OBJECT_BALL}

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var score: int = 0 setget _set_score
var high_score: int = 0 setget _set_high_score
var game_ready: bool = false

signal score_updated
signal game_over

func _ready() -> void:
	rng.randomize()

func _set_score(new_score):
	score = new_score
	print("Score: %d" % score)
	if score > high_score:
		high_score = score
	emit_signal("score_updated")

func _set_high_score(new_high_score):
	high_score = new_high_score
	print("!!NEW HIGH SCORE!! %d" % high_score)
