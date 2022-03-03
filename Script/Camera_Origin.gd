extends Spatial

const mouse_sensitivity_rot = 0.25
const mouse_sensitivity_tr = 0.001

var mouse_speed:Vector2

var mouse_have_move:bool

var zoom:float

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		mouse_speed = event.relative
		mouse_have_move = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_pressed("mouse_right") and mouse_have_move:
		rotate_y(-mouse_speed.x * delta * mouse_sensitivity_rot)
		mouse_have_move = false
	
	if Input.is_action_just_pressed("mouse_middle"):
		Input.warp_mouse_position(get_viewport().size/2)
		
	if Input.is_action_pressed("mouse_middle"):
		var mouse_lenght_from_center = get_viewport().get_mouse_position() - get_viewport().size/2
		
		translate(Vector3(mouse_lenght_from_center.x, 0, mouse_lenght_from_center.y) * mouse_sensitivity_tr)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
