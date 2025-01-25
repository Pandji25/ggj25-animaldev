extends RigidBody2D
class_name DamageObstacle

@export var straw: Straw
var x_push_force:float
var new_float = 0.0

func _process(delta: float) -> void:
	queue_redraw()

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var range_dir: Vector2
	if in_range_of(straw):
		var range_dirs = straw.global_position - global_position
		range_dir = range_dirs.normalized()
		apply_central_force(range_dir * 2500)
		new_float = lerp(new_float,1000.0,0.5)

func _draw() -> void:
	if in_range_of(straw):
		draw_line(Vector2.ZERO, straw.position - position, Color.RED)

func in_range_of(target: Node2D) -> bool:
	var dir: Vector2 = target.global_position - global_position
	var range: float = 600.0
	if dir.length() < range:
		return true
	else:
		return false
