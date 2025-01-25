extends TextureButton


func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")


func _on_mouse_entered() -> void:
	set_self_modulate(Color(0.822, 0.822, 0.822))


func _on_mouse_exited() -> void:
	set_self_modulate(Color(1, 1, 1))
