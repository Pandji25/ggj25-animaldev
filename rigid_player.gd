extends RigidBody2D
class_name RigidPlayer

signal player_destroyed

@export var health: int = 3
@export var speed: float = 200.0

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

func _process(_delta: float) -> void:
	print($Sprite2D.animation)

func play_emote():
	pass

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
	player_destroyed.emit()

func _on_body_entered(body: Node) -> void:
	if body is DamageObstacle:
		print("collided")
		var dir: Vector2 = global_position - body.global_position
		apply_central_impulse(dir.normalized()*1200)
		
		decrease_health(1)
