extends RigidBody2D
class_name RigidPlayer

signal player_destroyed

@export var health: int = 3
@export var speed: float = 3000.0

#indes for emotion for random integer
var emote_index: Dictionary = {0 : "smiley", 1 : "wink", 2 : "happy", 3 : "happyblink"}
#duration of emotion set by random integer
var emote_timer: Dictionary = {"smiley": 5,"happy" : 5,"happyblink" : 3, "wink": 2, }

func random_emote():
	#make random number
	var emotion = randi_range(0,3)
	#makes the random number an "emotion" 
	var currentemote = emote_index[emotion]
	#get the appropriate duration based on the dictionary
	var emoteduration = emote_timer[currentemote]
	$Emote_Timer.set_wait_time(emoteduration)
	$Sprite2D.play(currentemote)

func _on_emote_timer_timeout() -> void:
	random_emote()

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	# Gets keyboard input direction.
	var dir: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	dir.normalized()
	
	# Applies the forces to direction.
	if dir:
		apply_central_force(dir*speed)

# If health reaches zero it will wait for a bit before freeing itself.
func decrease_health(dmg:float) -> void:
	health -= dmg
	if health <= 0:
		await get_tree().create_timer(0.5).timeout
		destroy()

func destroy():
	queue_free()
	player_destroyed.emit()

func _on_body_entered(body: Node) -> void:
	# Calculates the direction of the push according to the position of self and
	# the DamageObstacle
	# Push force and Damage should probably be stored in the DamageObstacle instead.
	if body is DamageObstacle:
		var dir: Vector2 = global_position - body.global_position
		var push_force: float = 1200.0
		apply_central_impulse(dir.normalized()*push_force)
		
		decrease_health(1)
