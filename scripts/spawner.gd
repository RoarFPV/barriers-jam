extends Area3D

@export var delay_min:float = 1
@export var delay_max:float = 5

@export var customers:Array[CustomerData];

@onready var _shape = $CollisionShape3D.shape



var _goals: Array[Node]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_goals = get_tree().get_nodes_in_group("goal")
	# build weighted table
	

func _on_timer_timeout() -> void:
	spawn_customer()
	$Timer.wait_time = randf_range(delay_min, delay_max)
	
	
func spawn_customer():
	var data = customers.pick_random()
	
	var c = data.customer.instantiate()
	
	
	
	c.set_data(data)
	var goal = _goals.pick_random()
	c.goal = goal
	var offset = (_shape.extents/2) * randf_range(-1,1)
	offset.y =0
	c.global_position = global_position + offset
	add_sibling(c)
	
	
