extends Control

signal button_pressed(button_name)
signal button_pack_pressed(button_name)

var icon = preload("res://icon.png")

onready var node_score = $ScoreContainer/Score
onready var node_score_max = $ScoreContainer/ScoreMax
onready var node_building_panel = $BuildingPanel
onready var node_building = $BuildingContainer
onready var node_pack = $PackContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_score(score:int):
	node_score.text = str(score)
	
func update_score_max(score:int):
	node_score_max.text = str(score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func add_button_building(button_name:String):
	var button = TextureButton.new()
	
	button.name = button_name
	button.rect_min_size = Vector2(96, 96)
	
	if Load.pack_icons.has(button_name):
		button.texture_normal = Load.pack_icons[button_name]
		
		button.expand = true
		
		button.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
	else:
		button.texture_normal = icon
	
	button.connect("pressed", self, "_on_button_building_pressed", [button_name])
	
	node_building.add_child(button)

func add_button_pack(button_name:String):
	var button = TextureButton.new()
	
	button.name = button_name
	
	button.rect_min_size = Vector2(128, 128)
	
	if Load.pack_icons.has(button_name):
		button.texture_normal = Load.pack_icons[button_name]
		
		button.expand = true
		
		button.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
	else:
		button.texture_normal = icon
		
	button.connect("pressed", self, "_on_button_pack_pressed", [button_name])
	
	node_pack.add_child(button)

func hide_pack():
	node_pack.hide()
	
func show_pack():
	node_pack.show()

func hide_building():
	node_building_panel.hide()
	node_building.hide()
	
func show_building():
	node_building_panel.show()
	node_building.show()
	
func delete_button_building():
	for child in node_building.get_children():
		child.queue_free()

func _on_button_building_pressed(button_name):
	emit_signal("button_pressed", button_name)

func _on_button_pack_pressed(button_name):
	emit_signal("button_pack_pressed", button_name)
