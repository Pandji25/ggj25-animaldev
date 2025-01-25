extends RigidBody2D
class_name BodyTest

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	var range = randf_range(0.5, 1.5)
	collision_shape_2d.scale.x = range
	collision_shape_2d.scale.y = range
