extends Node3D
var in_range = false
var opened = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if in_range and Input.is_action_pressed("open") and not opened:
		opened = true
		$AnimationPlayer.play("Chest_Open")


	



func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		in_range = true
		$Area3D/Label3D["visible"] = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		in_range = false
		$Area3D/Label3D["visible"] = false
