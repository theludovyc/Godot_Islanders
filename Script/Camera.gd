extends Camera

var Building = preload("res://Scene/Building.tscn")
var mat_Lambert101 = preload("res://Art/Material/lambert101.material")

var building

onready var raycast = $RayCast

func pop_building():
	building = Building.instance()
	get_parent().call_deferred("add_child", building)

# Called when the node enters the scene tree for the first time.
func _ready():
	pop_building()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	
	raycast.cast_to = project_local_ray_normal(mouse_pos) * 50
	raycast.force_raycast_update()

	if raycast.is_colliding():
		building.visible = true
		building.translation = raycast.get_collision_point()
	else:
		building.visible = false

	if Input.is_action_just_pressed("mouse_left"):
		building.set_surface_material(0, mat_Lambert101)
		pop_building()
