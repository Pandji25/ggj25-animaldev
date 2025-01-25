extends RigidBody2D
class_name RigidPlayer

@export var health: int = 3
@export var speed: float = 200.0

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	# gets keyboard input
	var dir: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	dir.normalized()
	
	if dir:
		apply_central_force(dir*speed)

func decrease_health(dmg:float) -> void:
	health -= dmg
	if health <= 0:
		await get_tree().create_timer(0.5).timeout
		destroy()

func destroy():
	queue_free()

func _on_body_entered(body: Node) -> void:
	if body is DamageObstacle:
		print("collided")
		var dir: Vector2 = global_position - body.global_position
		apply_central_impulse(dir.normalized()*1200)
		
		decrease_health(1)
