extends Area

signal pop_building(bonus)

var mat_selec = preload("res://Art/Material/Selection.tres")
var mat_selec_red = preload("res://Art/Material/Selection_Red.tres")
var Building = preload("res://Scene/Adventure_Tower_01.tscn")

var isRed := false

var bonus:int

onready var mesh = $Mesh
onready var label = $Viewport/Label
onready var radar = $Radar
onready var sprite = $Sprite3D
onready var camera_origin = $"/root/Game/Camera_Origin"
onready var camera = $"/root/Game/Camera_Origin/Camera"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func pop():
	var building = Building.instance()
	building.translation = to_global(mesh.translation)
	get_parent().add_child(building)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite.look_at(camera_origin.to_global(camera.translation), Vector3.UP)

	if Input.is_action_just_pressed("mouse_left") and !isRed:
		emit_signal("pop_building", bonus)
		pop()

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
