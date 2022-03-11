extends Spatial

signal pop_building(bonus)

const rot_speed = PI/8

var mat_selec = preload("res://Art/Material/Selection.tres")
var mat_selec_red = preload("res://Art/Material/Selection_Red.tres")
var mat_lambert = preload("res://Art/Material/lambert101.material")

var isRed := false

var bonus:int

var building_name:String
var building
var mesh

var index := 0

onready var label = $Viewport/Label
onready var radar = $Radar
onready var sprite = $Sprite3D
onready var camera_origin = $"/root/Game/Camera_Origin"
onready var camera = $"/root/Game/Camera_Origin/Camera"
onready var game = get_parent()

func add_building():
	if !building_name.empty():
		building = Load.packs[game.current_pack_name][building_name].instance()
		
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
	pass # Replace with function body.

func reset():
	hide()
	
	if building:
		building_name = ""
		building.queue_free()
		building = null

func _unhandled_input(event):
	if event is InputEventMouseButton:
		match(event.button_index):
			BUTTON_LEFT:
				if event.pressed and !building_name.empty() and !isRed:
					pop_building()
					add_building()
					emit_signal("pop_building", bonus)
			
			BUTTON_RIGHT:
				if event.pressed:
					reset()
			
	if building != null:
		if event is InputEventMouseButton && event.button_index == BUTTON_WHEEL_UP:
			building.rotate_y(rot_speed)
		if event is InputEventMouseButton && event.button_index == BUTTON_WHEEL_DOWN:
			building.rotate_y(-rot_speed)

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

func calc_bonus():
	var list_buildings = radar.get_overlapping_areas()
	
	bonus = -1
	
	var b_groups = building.get_groups()
	
	if !b_groups.empty():
		for _building in list_buildings:
			if _building.is_in_group(building.get_groups()[0]):
				bonus += 2
			else:
				bonus += 1
	else:
		bonus = list_buildings.size()

func _on_Radar_area_entered(area):
	if building:
		calc_bonus()
		label.text = str(bonus)

func _on_Radar_area_exited(area):
	if building:
		calc_bonus()
		label.text = str(bonus)

func _on_GUI_button_pressed(button_name):
	if building:
		building.queue_free()
		building = null
	
	building_name = button_name
	
	add_building()
	label.show()
	pass # Replace with function body.
	
func hide():
	.hide()
	
	label.hide()
