extends Camera

const zoom_speed = 0.5
const zoom_min = 5
const zoom_max = 15

func add_zoom(z:float):
	size = clamp(size + z, zoom_min, zoom_max)

onready var selection = $"/root/Game/Selection"
onready var raycast = $RayCast
onready var origin = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if selection.building == null:
		if event is InputEventMouseButton && event.button_index == BUTTON_WHEEL_UP:
			add_zoom(-zoom_speed)
		if event is InputEventMouseButton && event.button_index == BUTTON_WHEEL_DOWN:
			add_zoom(zoom_speed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	
	raycast.translation = to_local(project_ray_origin(mouse_pos))
	raycast.force_raycast_update()

	if raycast.is_colliding():
		selection.visible = true
		selection.translation = raycast.get_collision_point()
	else:
		selection.visible = false
