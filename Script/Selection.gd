extends Spatial

signal pop_building(bonus)

var mat_selec = preload("res://Art/Material/Selection.tres")
var mat_selec_red = preload("res://Art/Material/Selection_Red.tres")
var mat_lambert = preload("res://Art/Material/lambert101.material")
var Buildings = {"Adventure_Tower_01":preload("res://Scene/Adventure_Tower_01.tscn"),
				"Adventure_House_01":preload("res://Scene/Adventure_House_01.tscn")}

var isRed := false

var bonus:int

var building_name = "Adventure_Tower_01"
var building
var mesh

var index := 0

onready var label = $Viewport/Label
onready var radar = $Radar
onready var sprite = $Sprite3D
onready var camera_origin = $"/root/Game/Camera_Origin"
onready var camera = $"/root/Game/Camera_Origin/Camera"

func add_building():
	building = Buildings[building_name].instance()
	
	mesh = building.get_node("MeshInstance")
	mesh.set_surface_material(0, mat_selec)
	
	building.connect("area_entered", self, "_on_Building_area_entered")
	building.connect("area_exited", self, "_on_Building_area_exited")
	
	add_child(building)

func reparent(node):
	get_parent().add_child(node)

func pop_building():
	mesh.set_surface_material(0, mat_lambert)
	
	building.monitoring = false
	building.disconnect("area_entered", self, "_on_Building_area_entered")
	building.disconnect("area_exited", self, "_on_Building_area_exited")
	
	remove_child(building)
	
	building.translation = translation
	
	call_deferred("reparent", building)

# Called when the node enters the scene tree for the first time.
func _ready():
	add_building()
	pass # Replace with function body.

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and !isRed:
			emit_signal("pop_building", bonus)
			pop_building()
			add_building()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite.look_at(camera_origin.to_global(camera.translation), Vector3.UP)

func _on_Building_area_entered(area):
	mesh.set_surface_material(0, mat_selec_red)
	isRed = true
	pass # Replace with function body.

func _on_Building_area_exited(area):
	if building.get_overlapping_areas().empty():
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

func _on_GUI_button_pressed(button_name):
	building.queue_free()
	
	building_name = button_name
	
	add_building()
	pass # Replace with function body.
