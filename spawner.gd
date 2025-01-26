extends Marker2D

var obstacle_scenes: Array = []

@export var obs_spawn_timer: Timer

const OBSTACLE_1 = preload("res://obstacles/obstacle_1.tscn")
const OBSTACLE_2 = preload("res://obstacles/obstacle_2.tscn")
const OBSTACLE_3 = preload("res://obstacles/obstacle_3.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Goes through obstacles folder and lists all the scenes in it,
	# then load them and put them into an array
	#var files = DirAccess.get_files_at("res://obstacles")
	#for file in files:
	#	obstacle_scenes.append(load("res://obstacles/"+file))
	obstacle_scenes = [OBSTACLE_1, OBSTACLE_2, OBSTACLE_3]
	
	pick_random_obs()
	
	obs_spawn_timer.start()

func pick_random_obs() -> void:
	# Picks a random obstacle from array and instantiates it.
	var to_instantiate: PackedScene = obstacle_scenes.pick_random()
	add_child(to_instantiate.instantiate())
	
	# If the spawner has more than 3 children, frees the oldest.
	if get_child_count() > 6:
		get_child(0).queue_free()

func _on_obs_spawn_timer_timeout() -> void:
	pick_random_obs()
	
	obs_spawn_timer.start()
