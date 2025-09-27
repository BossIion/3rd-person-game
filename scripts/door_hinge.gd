extends Node3D

var in_range = false
var door_opened = false
func _ready() -> void:
	pass # Replace with function body.

var debounce = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if debounce:
		if in_range and Input.is_action_just_pressed("open") and door_opened == false:
			debounce = false
			door_opened = true
			$CSGBox3D2/AnimationPlayer.play("door_open")
			$Timer.start()
		elif in_range and Input.is_action_just_pressed("open") and door_opened:
			debounce = false
			door_opened = false
			$CSGBox3D2/AnimationPlayer.play("door_close")
			$Timer.start()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		in_range = true




func _on_timer_timeout():
	debounce = true
	
