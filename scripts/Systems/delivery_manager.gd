extends Node


var packages : Array[Package]
var _packages_delivered : Array[bool]
var delivery_points : Array[Node3D]
var package_spawns : Array[Node]

var score : int = 0

@export var spawn_delay_seconds:float = 30
@export var packageResource:Resource 
@onready var spawnTimer = $SpawnTimer
var packageTemplate = preload("res://platformer/package.tscn")

func add_delivery_point(point:Node3D):
	delivery_points.append(point)

func add_package(package:Package):
	var index = packages.size()
	packages.append(package)
	_packages_delivered.append(false)
	
func try_deliver_package(package:Package, delivery_point:Node3D, carrier:Node3D) -> bool:
	var index = packages.find(package)
	if index == -1 or _packages_delivered[index]:
		return false
	
	_packages_delivered[index] = true
	score += package.value
	ScoreManager.add_score(package.value)
	return true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	package_spawns = get_tree().get_nodes_in_group("delivery_package_spawn")
	spawnTimer.autostart = false

func total_package_count():
	return packages.size()
	
func all_packages_delivered() -> bool:
	return _packages_delivered.all(func(delivered): return delivered)
	
func packages_delivered() -> int:
	var delivered_list = _packages_delivered.filter(func(delivered): return delivered)
	return delivered_list.size()
	
func reset():
	spawnTimer.start()
	_packages_delivered.clear()
	packages.clear()
	score = 0


func _on_spawn_timer_timeout() -> void:
	var spawnPoint = package_spawns.pick_random()
	if spawnPoint:
		var package = packageResource.instantiate()
		add_child(package)
		package.global_position = spawnPoint.global_position
	
