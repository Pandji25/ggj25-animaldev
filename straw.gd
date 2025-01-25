extends Area2D
class_name Straw

@export var target: RigidPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if target:
		target.player_destroyed.connect(_on_player_destroyed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if target:
		look_at(target.global_position)
		rotation_degrees = clamp(rotation_degrees, 30, 150)
		global_position.x = lerp(global_position.x, target.global_position.x, 0.05)
		


func _on_body_entered(body: Node2D) -> void:
	if body is RigidPlayer:
		var to_delete = body
		
		to_delete.decrease_health(3)
		body = null
		await get_tree().create_timer(1).timeout
		get_tree().reload_current_scene()
	if body is DamageObstacle:
		var to_delete = body
		
		to_delete.queue_free()
		body = null

func _on_player_destroyed():
	target = null
