extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"."["visible"] = false
	position.y -= 50
	pass

func build_bridge():
	if $"../Player".wood >= 21:
		position.y += 50
		$"."["visible"] = true
