extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"."["visible"] = false
	position.y -= 50
	pass

func build_bridge():
	if $"../../Player".wood >= 3:
		$"../../Player".wood = $"../../Player".wood - 3
		$"../../Label".text = "Wood " + str($"../../Player".wood)
		position.y += 50
		$"."["visible"] = true
