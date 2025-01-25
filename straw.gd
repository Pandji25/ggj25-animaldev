extends Area2D
class_name Straw

@export var target: RigidPlayer


func _ready() -> void:
	# Connects the player_destroyed signal.
	if target:
		target.player_destroyed.connect(_on_player_destroyed)
	else:
		print("No target set for Straw.")

func _physics_process(delta: float) -> void:
	# Moves and rotates the straw ensuring it to always aim towards the player.
	# Would be best if there are nodes that act as limits for the movement.
	if target:
		look_at(target.global_position)
		rotation_degrees = clamp(rotation_degrees, 30, 150)
		global_position.x = lerp(global_position.x, target.global_position.x, 0.1)


func _on_body_entered(body: Node2D) -> void:
	if body is RigidPlayer:
		# Queues the entered body for deletion.
		var to_delete = body
		
		to_delete.decrease_health(3)
		body = null
		# Waits for a bit before reloading the scene.
		await get_tree().create_timer(2).timeout
		get_tree().reload_current_scene()
	
	if body is DamageObstacle:
		# Queues the entered body for deletion.
		var to_delete = body
		
		to_delete.queue_free()
		body = null

func _on_player_destroyed():
	# Makes sure that the target doesn't return an error.
	# Probably best if there is a default position for the straw to lock on
	# if the player is destroyed.
	target = null
