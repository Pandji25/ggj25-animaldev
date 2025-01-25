extends DamageObstacle
class_name VariantDamageObstacle

@export var sprite_element: Array[Sprite2D]
@export var collision_element: Array[CollisionPolygon2D]


func setup():
	randomize()
	if sprite_element.size() != collision_element.size():
		push_error("element size mismatch")
		return
	
	if sprite_element.size() > 0 and collision_element.size() > 0:
		for sprite in sprite_element:
			sprite.visible = false
		for coll in collision_element:
			coll.disabled = true
		randomize_variant(sprite_element.size()-1)
	else:
		push_error("one or more element array is missing")


func randomize_variant(count: int):
	var variant = randi_range(0, count)
	if sprite_element[variant] and collision_element[variant]:
		sprite_element[variant].visible = true
		collision_element[variant].disabled = false
