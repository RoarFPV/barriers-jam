extends Node3D

var _data:CustomerData
var goal:Node3D
var speed:float = 1
@onready var _nav_agent = %nav_agent
var anim:AnimationPlayer
@onready var body = %pb_body

@export var drag:float = 0.8

func _ready() -> void:
	anim = %AnimationPlayer
	%pb_body.global_position = global_position
	#if anim:
		#anim.play("Idle")
func set_data(data:CustomerData):
	_data = data
	speed = data.random_speed()
	
	

func set_goal(node:Node3D):
	goal = node

func _physics_process(delta: float) -> void:
	var input_dir = Vector3.ZERO
	
	if goal:
		_nav_agent.set_target_position(goal.position)
		
	var look
	if not _nav_agent.is_navigation_finished():
		
		var targetPos = _nav_agent.get_next_path_position()
		var targetVec = targetPos - global_position
		var targetDir = targetVec.normalized()
		targetDir.y = 0
		input_dir = targetDir
		
		
		 
		
		#rotation.x = 0
		#rotation.z = 0
		if %BodyControl:
			look = %BodyControl.transform.looking_at(targetPos, Vector3.UP)
			%BodyControl.rotation.y = look.basis.get_euler().y
			DebugDraw.draw_ray_3d(global_position, look.basis.x, 1, Color.RED)
			DebugDraw.draw_ray_3d(global_position, look.basis.y, 1, Color.GREEN)
			DebugDraw.draw_ray_3d(global_position, look.basis.z, 1, Color.BLUE)
		#input_dir = (transform.basis * Vector3(0, 0, -1)).normalized()
		#DebugDraw.draw_ray_3d(transform.origin, input_vel, 3, Color.AZURE)
		body.linear_velocity += (((input_dir * speed) + input_vel * speed) - body.linear_velocity * drag) * delta
		var spd =  body.linear_velocity.length()
		if spd > 0.001:
			anim.play("Walk")
			anim.speed_scale =  0.8 #minf(0.25, spd / speed)
		else:
			anim.speed_scale = 1
			anim.play("Idle")
			
		
	global_transform.basis = %pb_root.global_transform.basis # * Basis.from_euler(Vector3(0,180,0))
	global_transform.origin = %pb_root.global_transform.origin
	#global_transform = %pb_body.global_transform
	
	#rotation.y= look

var input_vel:Vector3

func _on_nav_agent_velocity_computed(safe_velocity: Vector3) -> void:
	input_vel = safe_velocity.normalized() # Replace with function body.
