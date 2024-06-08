extends Resource
class_name CustomerData

@export var customer:Resource
@export var spawn_weight:int = 1
@export var score:int = 1
@export var speed_min:float = 5
@export var speed_max:float = 10



func random_speed() -> float:
	return randf_range(speed_min, speed_max)
