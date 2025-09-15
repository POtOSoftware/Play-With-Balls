extends Area2D

func _on_Hole_body_entered(body):
	if body.ball_type != null:
		if body.ball_type == GameManager.ball_types.CUE_BALL:
			print("YOU SUCK!")
			body.queue_free()
		elif body.ball_type == GameManager.ball_types.OBJECT_BALL:
			print("bwaaaaah :3")
			body.queue_free()
		else:
			printerr("%s is not a valid ball type!" % body.name)
	else:
		print("%s is not a ball at all" % body.name)
