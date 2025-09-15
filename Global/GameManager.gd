extends Node

enum ball_types {CUE_BALL, OBJECT_BALL}

var score: int = 0 setget _set_score

signal score_updated
signal game_over

func _set_score(new_score):
	score = new_score
	print("Score: %d" % score)
	emit_signal("score_updated")
