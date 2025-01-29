extends RigidBody2D
class_name RigidPlayer

signal player_destroyed

@export var health: int = 4
@export var speed: float = 3000.0

# indes for emotion for random integer
var emote_index: Dictionary = {0 : "smiley", 1 : "wink", 2 : "happy", 3 : "happyblink"}
# duration of emotion set by random integer
var emote_timer: Dictionary = {"smiley": 5,"happy" : 5,"happyblink" : 3, "wink": 2, }

var input_enabled: bool = true

@onready var input_timer: Timer = $InputTimer
@onready var hurt_frames: SpriteFrames = preload("res://boba_hurt.tres")
@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var voice_audio: AudioStreamPlayer = $VoiceAudio
@onready var voice_timer: Timer = $VoiceTimer

const DEAD = preload("res://Assett/Audio/Dead.ogg")
const OUCH = preload("res://Assett/Audio/Ouch.ogg")

const HAHA = preload("res://Assett/Audio/Haha.ogg")
const YAY = preload("res://Assett/Audio/Yay.ogg")
const YIPEE = preload("res://Assett/Audio/Yipee.ogg")

const BOUNCE = preload("res://Assett/Audio/Bounce.ogg")
const ICE_CLANK_1 = preload("res://Assett/Audio/Ice clank 1.ogg")
const STAB = preload("res://Assett/Audio/Stab.ogg")
const ICE_CLANK_2 = preload("res://Assett/Audio/Ice clank 2.ogg")

func _ready() -> void:
	randomize()
	play_voice_audio()
	voice_timer.start(randf_range(5.0, 10.0))

func random_emote():
	# make random number
	var emotion = randi_range(0,3)
	# makes the random number an "emotion" 
	var currentemote = emote_index[emotion]
	# get the appropriate duration based on the dictionary
	var emoteduration = emote_timer[currentemote]
	$Emote_Timer.set_wait_time(emoteduration)
	$Sprite2D.play(currentemote)

func _on_emote_timer_timeout() -> void:
	if health >= 4:
		random_emote()

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	# Gets keyboard input direction.
	var dir: Vector2 = Input.get_vector("left", "right", "up", "down")
	dir.normalized()
	
	# Applies the forces to direction.
	if dir and input_enabled:
		apply_central_force(dir*speed)

# If health reaches zero it will wait for a bit before freeing itself.
func decrease_health(dmg: float) -> void:
	health -= dmg
	
	if health < 4:
		sprite.sprite_frames = hurt_frames
		match health:
			3:
				sprite.play(&"hurt_1")
			2: 
				sprite.play(&"hurt_2")
			1:
				sprite.play(&"hurt_3")
		if health == 1 and dmg > 0:
			$boba_headgib_hurt.emitting=true
		if health > 0 and dmg > 0:
			voice_audio.stream = OUCH
			voice_audio.play()
			$boba_gibs_hurt.emitting=true
			$boba_gibs_hurt.restart()
		elif health <= 0 and dmg > 0:
			voice_audio.stream = DEAD
			voice_audio.play()
			$boba_gibs_death.emitting=true
			$boba_gibs_death.restart()
	if health <= 0:
		sprite.play(&"death")
		if dmg >= 4 and health > -3:
			$boba_headgib_instadeath.emitting=true
		else:  
			$boba_headgib_death.emitting=true
		await get_tree().create_timer(0.5).timeout
		destroy()

func destroy():
	queue_free()
	player_destroyed.emit()

func play_voice_audio() -> void:
	var voice_lines: Array = [HAHA, YAY, YIPEE]
	voice_audio.stream = voice_lines.pick_random()
	voice_audio.play()

func play_sfx(stream: AudioStream):
	var sfx = AudioStreamPlayer.new()
	
	get_tree().root.add_child(sfx)
	sfx.stream = stream
	sfx.play()
	await sfx.finished
	sfx.queue_free()

func _on_body_entered(body: Node) -> void:
	# Calculates the direction of the push according to the position of self and
	# the DamageObstacle.
	# Takes the properties of DamageObstacle and apply it to knockback and damage.
	if body is DamageObstacle:
		var dir: Vector2 = global_position - body.global_position
		var push_force: float = body.push_force
		var damage: int = body.damage
		
		if push_force <= 0:
			var sound = [ICE_CLANK_1, ICE_CLANK_2]
			play_sfx(sound.pick_random())
		elif push_force > 0 and damage <= 0:
			play_sfx(BOUNCE)
		else:
			play_sfx(STAB)
		
		if push_force > 0:
			apply_central_impulse(dir.normalized()*push_force)
			# Disables input momentarily
			input_enabled = false
			input_timer.start()
		
		decrease_health(damage)


func _on_input_timer_timeout() -> void:
	input_enabled = true


func _on_voice_timer_timeout() -> void:
	if health >= 3:
		play_voice_audio()
		voice_timer.start(randf_range(5.0, 10.0))
