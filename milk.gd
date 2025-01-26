extends CanvasGroup

var speed:float = 500

func _process(_delta: float) -> void:
	position.y -= speed * _delta
	if position.y < -2048:
		position.y = 0
	print(position.y)
