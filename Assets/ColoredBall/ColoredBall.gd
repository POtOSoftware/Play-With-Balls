extends RigidBody2D

onready var ball_sprite: Node = $Sprite

export var ball_color: Color = Color(1, 1, 1, 1)
export var randomize_color: bool = false

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	if randomize_color:
		rng.randomize()
		var random_r: float = rng.randf_range(0, 1)
		var random_b: float = rng.randf_range(0, 1)
		var random_g: float = rng.randf_range(0, 1)
		
		ball_color = Color(random_r, random_b, random_g, 1)
		ball_sprite.modulate = ball_color
