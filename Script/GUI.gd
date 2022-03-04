extends Control

onready var node_score = $Score

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_score(score:int):
	node_score.text = str(score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
