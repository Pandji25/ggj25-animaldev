extends Area2D
class_name Straw

@export var target: RigidPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	look_at(target.global_position)
	global_position.x = lerp(global_position.x, target.global_position.x, 0.05)


func _on_body_entered(body: Node2D) -> void:
	if body is PlayerBoba:
		body.queue_free()
		await get_tree().create_timer(1).timeout
		get_tree().reload_current_scene()
