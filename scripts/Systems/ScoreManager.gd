extends Node3D


var score : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func add_score(count:int):
	score += count
