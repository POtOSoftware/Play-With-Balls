extends RigidBody2D

onready var ball_sprite: Node = $Sprite

export var ball_color: Color = Color(1, 1, 1, 1)
export var randomize_color: bool = false

var ball_type: int = GameManager.ball_types.OBJECT_BALL

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	if randomize_color:
		rng.randomize()
		var random_r: float = rng.randf_range(0, 1)
		var random_b: float = rng.randf_range(0, 1)
		var random_g: float = rng.randf_range(0, 1)
		
		ball_color = Color(random_r, random_b, random_g, 1)
		ball_sprite.modulate = ball_color

func _integrate_forces(state):
	# you have to be kidding me...
	rotation_degrees = 0

func _on_ColoredBall_sleeping_state_changed():
	print("Ball %s | Sleeping: %s" % [self.name, self.sleeping]) 
