extends Area

var mat_selec = preload("res://Art/Material/Selection.tres")
var mat_selec_red = preload("res://Art/Material/Selection_Red.tres")
var Building = preload("res://Scene/Building.tscn")

var isRed := false

var bonus:int

#Edit from Camera.gd
var camera
var camera_origin

onready var mesh = $Mesh
onready var label = $Viewport/Label
onready var radar = $Radar
onready var sprite = $Sprite3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var camera_global_pos = camera_origin.to_global(camera.translation)
	
	var sprite_global_pos = to_global(sprite.translation)
	
	sprite.look_at(Vector3(sprite_global_pos.x, camera_global_pos.y, camera_global_pos.z), Vector3.UP)
#	pass

func pop():
	var building = Building.instance()
	building.translation = to_global(mesh.translation)
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

func _on_Radar_area_entered(area):
	bonus = radar.get_overlapping_areas().size()
	label.text = str(bonus)
	pass # Replace with function body.

func _on_Radar_area_exited(area):
	bonus = radar.get_overlapping_areas().size()
	label.text = str(bonus)
	pass # Replace with function body.
