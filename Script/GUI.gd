extends Control

signal button_pressed(button_name)
signal button_pack_pressed(button_name)

var icon = preload("res://icon.png")

onready var node_score = $ScoreContainer/Score
onready var node_score_max = $ScoreContainer/ScoreMax
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
	if !node_building.has_node(button_name):
		var button = TextureButton.new()
		button.name = button_name
		
		button.texture_normal = icon
		
		button.connect("pressed", self, "_on_button_building_pressed", [button_name])
		
		node_building.add_child(button)
	
func hide_pack():
	node_pack.hide()
	
func show_pack():
	node_pack.show()

func _on_button_building_pressed(button_name):
	emit_signal("button_pressed", button_name)

func _on_Pack_Adventure_Tower_pressed():
	emit_signal("button_pack_pressed", "Pack_Adventure_Tower")
	pass # Replace with function body.


func _on_Pack_Adventure_House_pressed():
	emit_signal("button_pack_pressed", "Pack_Adventure_House")
	pass # Replace with function body.
