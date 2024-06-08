extends CharacterBody3D


@export var SPEED:float = 3.0
@export var JUMP_VELOCITY:float = 4.5
@export var attack_delay:float = 3

#@onready var animation = $Orc2/AnimationPlayer
#@onready var animTree = $Orc2/AnimationTree
#@onready var animState = animTree["parameters/main/playback"]

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	#else:
		#animation.play("Idle", 0.1)
		
	var input_dir = Vector3.ZERO
	
	if target:
		_nav_agent.set_target_position(target.position)
		
	if not _nav_agent.is_navigation_finished():
		
		var targetPos = _nav_agent.get_next_path_position()
		var targetVec =  position - targetPos
		var targetDir = targetVec.normalized()
		targetDir.y = 0
		input_dir = targetDir
		
		var look = transform.looking_at(targetPos)
		
		transform = transform.interpolate_with(look, 5 * delta)
		rotation.x = 0
		rotation.z = 0
		
		input_dir = (transform.basis * Vector3(0, 0, -1)).normalized()
		
	if input_dir != Vector3.ZERO:
		velocity.x = input_dir.x * SPEED
		velocity.z = input_dir.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	move_and_slide()
	
var target:Node = null

func _on_body_entered(body):
	# Delete The Coin and Add Score
	if body.is_in_group("player"):
		target = body
		



#const Line3D = preload("res://line3d.gd")

@export var character_speed := 10.0
@export var show_path := true

@onready var _nav_agent := $NavigationAgent3D as NavigationAgent3D

#var _nav_path_line : Line3D
