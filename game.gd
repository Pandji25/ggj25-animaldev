extends Node2D
@onready var marker_2d: Marker2D = $Marker2D

var level_1: PackedScene = preload("res://level_1.tscn")
var new_level: Node2D

#func _ready() -> void:
#	new_level = level_1.instantiate()
#	add_child(new_level)
#	new_level.position = marker_2d.position

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_pressed("ui_cancel"):
		get_tree().quit()
