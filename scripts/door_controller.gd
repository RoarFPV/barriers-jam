extends RigidBody3D


@export var input_open:StringName
@export var input_close:StringName

@export var force:float = 20
@export var swing:bool = false
@export var close_pin:PinJoint3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("view_look"):
		return
		
	var input = Input.get_axis(input_open, input_close )
	
	#if close_pin:
		#if input:
			#close_pin.node_b = NodePath()
		#else:
			#close_pin.node_b = self.get_path()
		#close_pin.visible = input != 0
	
	
	if swing:
		apply_torque_impulse(Vector3.UP * input * force)
	else:
		apply_central_impulse(Vector3.RIGHT * input * force)
