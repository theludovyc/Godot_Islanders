extends Node

var Cube_Column = preload("res://Scene/Cube_Column.tscn")

const column_width = 5
const column_min_height = 0.25
const land_width = 3
const pop_threshold = -0.2
const counter_max = 3

var score := 0
var counter := 0

var current_pack_name:String

var used_packs:Array = []

onready var gui = $GUI
onready var selection = $Selection

# Called when the node enters the scene tree for the first time.
func _ready():
	for key in Load.packs:
		gui.add_button_pack(key)
	
	gui.update_score(score)
	gui.update_counter(counter)
	
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
	
	counter -= 1
	
	if counter == 0:
		gui.hide_building()
		selection.reset()
		gui.show_pack()
	
	gui.update_counter(counter)
	
	pass # Replace with function body.

func _on_GUI_button_pack_pressed(button_name):
	if !used_packs.has(button_name):
		score += 1
		gui.update_score(score)
		used_packs.push_back(button_name)
	
	counter = counter_max
	
	gui.update_counter(counter)
	
	if button_name != current_pack_name:
		current_pack_name = button_name
		
		var names = Load.packs[button_name]
		
		gui.delete_button_building()
		
		for _name in names:
			gui.add_button_building(_name)
	
	gui.hide_pack()
	gui.show_building()
	pass # Replace with function body.
