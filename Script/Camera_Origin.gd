extends Spatial

const mouse_sensitivity = 0.25

var mouse_speed:float

var mouse_have_move:bool

var zoom:float

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		mouse_speed = event.relative.x
		mouse_have_move = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_pressed("mouse_right") and mouse_have_move:
		rotate_y(-mouse_speed * delta * mouse_sensitivity)
		mouse_have_move = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
