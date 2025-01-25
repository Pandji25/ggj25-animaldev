extends Area2D


@export var bouyancy: float

func _physics_process(delta: float) -> void:
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body is RigidBody2D:
			body.constant_force = Vector2.ZERO
			body.add_constant_force(Vector2.DOWN * bouyancy)

func _on_body_entered(body: Node2D) -> void:
	pass
