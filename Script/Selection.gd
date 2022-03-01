extends Area

var mat_selec = preload("res://Art/Material/Selection.tres")
var mat_selec_red = preload("res://Art/Material/Selection_Red.tres")
var Building = preload("res://Scene/Building.tscn")

onready var mesh = $Mesh

var isRed := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func pop():
	var building = Building.instance()
	building.translation = translation
	get_parent().add_child(building)

func _on_area_entered(area):
	mesh.set_surface_material(0, mat_selec_red)
	isRed = true
	pass # Replace with function body.


func _on_Building_area_exited(area):
	if get_overlapping_areas().empty():
		isRed = false
		mesh.set_surface_material(0, mat_selec)
	pass # Replace with function body.
