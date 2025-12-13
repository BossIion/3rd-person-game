extends Area3D

var horiz_speed = 1
var rot_speed = 0.5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		global_transform = get_parent().get_child(0).global_transform


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position -= transform.basis.z * horiz_speed
	$lvl_9000_axe.rotate_object_local(Vector3(0,0,1),-rot_speed)


func _on_life_timer_timeout() -> void:
	queue_free()


func _on_area_entered(area: Area3D) -> void:
	if area.name == "Spiderbody":
		area.get_parent().get_node("GPUParticles3D").restart()
		area.get_parent().move_speed = 5
		await get_tree().create_timer(2).timeout
		
		area.get_parent().queue_free()
