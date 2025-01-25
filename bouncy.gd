extends VariantDamageObstacle




#this one is for random sizes
func _ready() -> void:
	setup()
	
	#placeholder.visible = false
	
	var sizes = randf_range(0.5, 1.5)
	scale.x = sizes
	scale.y = sizes

'''
func randomize_variant(count: int):
	var variant = randi_range(0, count)
	sprite_element[variant].visible = true
	collision_element[variant].disabled = false

#i make the type of the jello by enabling disabling the visibility and collision shapes
func type_jelly_a():
	$Jela.set_visible(true)
	$cola.set_disabled(false)
	$Jelb.set_visible(false)
	$colb.set_disabled(true)
	$Jelc.set_visible(false)
	$colc.set_disabled(true)

func type_jelly_b():
	$Jela.set_visible(false)
	$cola.set_disabled(true)
	$Jelb.set_visible(true)
	$colb.set_disabled(false)
	$Jelc.set_visible(false)
	$colc.set_disabled(true)

func type_jelly_c():
	$Jela.set_visible(false)
	$cola.set_disabled(true)
	$Jelb.set_visible(false)
	$colb.set_disabled(true)
	$Jelc.set_visible(true)
	$colc.set_disabled(false)
	
func randomize_jelly_type():
	var type = randi_range(0, 2)
	if type == 0:
		type_jelly_a()
	if type == 1:
		type_jelly_b()
	if type == 2:
		type_jelly_c()
'''
