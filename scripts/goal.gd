extends Area3D


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("customer"):
		body.queue_free()


func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("customer"):
		area.queue_free()# Replace with function body.


func _on_area_shape_entered(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("customer"):
		area.queue_free()#
