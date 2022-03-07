extends Control

signal button_pressed(button_name)

onready var node_score = $ScoreContainer/Score
onready var node_score_max = $ScoreContainer/ScoreMax

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

func _on_Adventure_Tower_01_pressed():
	emit_signal("button_pressed", "Adventure_Tower_01")
	pass # Replace with function body.


func _on_Adventure_House_01_pressed():
	emit_signal("button_pressed", "Adventure_House_01")
	pass # Replace with function body.
