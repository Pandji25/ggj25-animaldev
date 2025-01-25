extends RigidBody2D
class_name BodyTest

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	var val_range = randf_range(0.5, 1.2)
	collision_shape_2d.scale.x = val_range
	collision_shape_2d.scale.y = val_range
