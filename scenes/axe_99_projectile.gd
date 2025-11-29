extends Area3D

var horiz_speed = 0.5
var rot_speed = 0.1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		rotate_object_local(Vector3(0,1,0),100)
		global_transform = get_parent().get_child(0).global_transform


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position -= transform.basis.z * horiz_speed
	$lvl_9000_axe.rotate_object_local(Vector3(1,0,0),rot_speed)
