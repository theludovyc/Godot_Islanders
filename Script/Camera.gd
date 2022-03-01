extends Camera

var Selection = preload("res://Scene/Selection.tscn")

var selection

onready var raycast = $RayCast
onready var origin = get_parent()

func pop_selection():
	selection = Selection.instance()
	get_node("/root/Game").call_deferred("add_child", selection)

# Called when the node enters the scene tree for the first time.
func _ready():
	pop_selection()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	
	raycast.cast_to = project_local_ray_normal(mouse_pos) * 50
	raycast.force_raycast_update()

	if raycast.is_colliding():
		selection.visible = true
		selection.translation = raycast.get_collision_point()
	else:
		selection.visible = false

	if Input.is_action_just_pressed("mouse_left") and !selection.isRed:
		selection.pop()
