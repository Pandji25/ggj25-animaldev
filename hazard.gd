extends VariantDamageObstacle



func _ready() -> void:
	setup()
	
	var sizes = randf_range(0.5, 1.5)
	scale.x = sizes
	scale.y = sizes
