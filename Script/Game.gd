extends Node

var Cube_Column = preload("res://Scene/Cube_Column.tscn")

const column_width = 5
const column_min_height = 0.25
const land_width = 3
const pop_threshold = -0.2
const packs = {"Adventure":["Adventure_Tower_01", "Adventure_House_01"]}

var score := 0
var score_max := 2

onready var gui = $GUI
onready var selection = $Selection

# Called when the node enters the scene tree for the first time.
func _ready():
	for key in packs:
		gui.add_button_pack(key)
	
	gui.update_score(score)
	gui.update_score_max(score_max)
	
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
	
	if score > score_max:
		score = 0
		gui.hide_building()
		selection.reset()
		gui.show_pack()
	
	gui.update_score(score)
	pass # Replace with function body.

func _on_GUI_button_pack_pressed(button_name):
	var names = packs[button_name]
	
	for _name in names:
		gui.add_button_building(_name)
	
	gui.hide_pack()
	gui.show_building()
	pass # Replace with function body.
