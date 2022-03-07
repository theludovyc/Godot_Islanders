extends Node

var Cube_Column = preload("res://Scene/Cube_Column.tscn")

const column_width = 5
const column_min_height = 0.25
const land_width = 3
const pop_threshold = -0.2

var score := 0

onready var gui = $GUI

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	var noise = OpenSimplexNoise.new()
	
	# Configure
	noise.seed = randi()
	noise.octaves = 9
	noise.period = 0.1
	noise.persistence = 0
	
	for i in land_width:
		for j in land_width:
			var column = Cube_Column.instance()
			var noi = noise.get_noise_2d(i, j)
			
			prints("Game", noi)
			
			if noi > pop_threshold:
				column.translation = Vector3(column_width*i, column_min_height + noi + -pop_threshold, column_width*j)
				add_child(column)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Selection_pop_building(bonus):
	score += bonus
	gui.update_score(score)
	pass # Replace with function body.
