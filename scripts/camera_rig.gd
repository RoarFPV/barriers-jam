extends Node3D

var targetCameraRotation:Vector3


@export var look_sensitivity:float = 1.0
@export var follow_sensitivity:float = 1

var freeMode:bool = false

func _ready() -> void:
	top_level = true
	targetCameraRotation = rotation_degrees
	
	

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("view_look") and event is InputEventMouseMotion:
		targetCameraRotation.y -= event.relative.x * look_sensitivity
		targetCameraRotation.x = clamp(targetCameraRotation.x - event.relative.y * look_sensitivity, -90, 90)

func _process(delta: float) -> void:
	var look_dir:Vector2
	if Input.is_action_pressed("view_look"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		var move = Input.get_vector("move_left", "move_right", "move_backward", "move_forward")
		
		position += transform.basis * Vector3(move.x, 0, -move.y) * delta
		#look_dir = Input.get_vector("look_up", "look_down", "look_left", "look_right")
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	
	#if look_dir:
		#targetCameraRotation.y -= look_dir.y * look_sensitivity
		#targetCameraRotation.x = clamp(targetCameraRotation.x - look_dir.x * look_sensitivity, -90, 90)
	#
	# Smoothly follow player's position
	rotation_degrees = lerp(rotation_degrees, targetCameraRotation, delta * follow_sensitivity)
