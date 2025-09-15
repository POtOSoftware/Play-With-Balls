extends RigidBody2D

onready var firing_direction: Node = $Arrow

var ball_type: int = GameManager.ball_types.CUE_BALL
var firing: bool = true

func _ready() -> void:
	set_process(false)
	if firing:
		setup_firing()

func _process(delta):
	firing_direction.rotation_degrees += 1
	if Input.is_action_just_pressed("action_button"):
		var fire_direction: float = deg2rad(firing_direction.rotation_degrees)
		print("Fire direction: %f" % fire_direction)
		apply_central_impulse(Vector2(cos(fire_direction) * 100, sin(fire_direction) * 100))
		print("Fire impulse X: %f | Y: %f" % [cos(fire_direction) * 100, sin(fire_direction) * 100])
		stop_firing()

func _integrate_forces(state):
	# you have to be kidding me...
	rotation_degrees = 0

func setup_firing() -> void:
	firing_direction.visible = true
	set_process(true)

func stop_firing() -> void:
	set_process(false)
	firing_direction.visible = false
	firing_direction.rotation_degrees = 0

func _on_CueBall_sleeping_state_changed():
	print("Cue Ball | Sleeping %s" % self.sleeping)
	if self.sleeping:
		setup_firing()
