extends Node2D
class_name Stage


func _input(event: InputEvent) -> void:
	# Will probably be changed into pause.
	if event is InputEventKey and event.is_action_pressed("ui_cancel"):
		get_tree().quit()
