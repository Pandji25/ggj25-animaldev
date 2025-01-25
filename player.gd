extends CharacterBody2D
class_name PlayerBoba


@export var max_speed: float = 500
@export var acceleration: float = 0.1
@export var suck_force: float = 200
@export var straw: Straw


func _physics_process(delta: float) -> void:
	# Redraws debugging visuals.
	queue_redraw()
	
	# Gets keyboard inputs
	var dir: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	dir.normalized()
	
	# Calculates the velocity based on inputs. 
	# If the player is not moving it will apply upward force.
	# This upward force maybe rebranded as game speed instead of suck force and
	# will be game-adjustabele.
	if dir:
		velocity = lerp(velocity, dir*max_speed, acceleration)
	else :
		velocity = lerp(velocity, Vector2.UP * suck_force, acceleration)
	
	# Very dirty code that applies suction force to player.
	var range_dir: Vector2
	if in_range_of(straw):
		var range_dirs = straw.global_position - global_position
		range_dir = range_dirs.normalized()
		var suction_force: float = 30.0
		velocity += range_dir * suction_force
	
	move_and_slide()
	
	# applies force to rigidbody obstacles.
	for i in get_slide_collision_count():
		var c:KinematicCollision2D = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			var body: RigidBody2D = c.get_collider()
			var push_force: float = 10.0
			body.apply_central_impulse(-c.get_normal() * push_force)

# Debugging
func _draw() -> void:
	if in_range_of(straw):
		draw_line(Vector2.ZERO, straw.position - position, Color.RED)

# Helper function to check if the player is in range of the straw.
# Might have to make this a baseclass function since other things might
# get sucked into the straw.
func in_range_of(target: Node2D) -> bool:
	var dir: Vector2 = target.global_position - global_position
	var range: float = 600.0
	if dir.length() < range:
		return true
	else:
		return false

func knockback():
	pass
