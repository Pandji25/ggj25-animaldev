extends Node2D
class_name Stage

@onready var level_progression: AnimationPlayer = $LevelProgression
@onready var boba: RigidPlayer = $Boba


func _ready() -> void:
	boba.player_destroyed.connect(_on_player_destroyed)
	level_progression.play(&"level_progress")

func _input(event: InputEvent) -> void:
	# Will probably be changed into pause.
	if event is InputEventKey and event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_player_destroyed():
	await get_tree().create_timer(2.0).timeout
	get_tree().reload_current_scene()
