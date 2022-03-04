extends Node

var Cube_Column = preload("res://Scene/Cube_Column.tscn")

var score := 0

onready var gui = $GUI

# Called when the node enters the scene tree for the first time.
func _ready():
	var noise = OpenSimplexNoise.new()
	
	# Configure
	noise.seed = randi()
	noise.octaves = 9
	noise.period = 0.1
	noise.persistence = 0
	
	var vec_max = Vector2(5, 5)
	var vec_center = vec_max/2
	
	for i in 5:
		for j in 5:
			var column = Cube_Column.instance()
			var noi = noise.get_noise_2d(i, j)
			
			var vec = Vector2(i, j) - vec_center
			
			column.translation = Vector3(5*i, noi + vec.normalized().length() , 5*j)
			add_child(column)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Selection_pop_building(bonus):
	score += bonus
	gui.update_score(score)
	pass # Replace with function body.
