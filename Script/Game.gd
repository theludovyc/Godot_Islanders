extends Node

var score := 0

onready var gui = $GUI

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Selection_pop_building(bonus):
	score += bonus
	gui.update_score(score)
	pass # Replace with function body.
