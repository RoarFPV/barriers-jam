extends RigidBody3D


@export var input_open:StringName
@export var input_close:StringName

@export var force:float = 20
@export var swing:bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	var input = Input.get_axis(input_open, input_close )
	
	if swing:
		apply_torque_impulse(Vector3.UP * input * force)
	else:
		apply_central_impulse(Vector3.RIGHT * input * force)
