extends Camera

const zoom_speed = 0.5
const zoom_min = 5
const zoom_max = 15

var Selection = preload("res://Scene/Selection.tscn")

var selection

func pop_selection():
	selection = Selection.instance()
	get_node("/root/Game").call_deferred("add_child", selection)

func add_zoom(z:float):
	size = clamp(size + z, zoom_min, zoom_max)

onready var raycast = $RayCast
onready var origin = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pop_selection()
	pass # Replace with function body.

func _unhandled_input(event):
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

	if Input.is_action_just_pressed("mouse_left") and !selection.isRed:
		selection.pop()
