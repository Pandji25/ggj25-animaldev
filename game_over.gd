extends Node2D

@export var stage: Stage

func _ready() -> void:
	stage.playerded.connect(_on_playerdead)
	

func _on_playerdead() -> void:
	visible = true
	$Recipt_anim.play("Recipt_Handout")
