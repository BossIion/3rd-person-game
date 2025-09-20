extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"."["visible"] = false
	pass


func grow_forest():
	if $"../Player".wood >= 4:
		$"../Player".wood = $"../Player".wood - 4
		$"../Label".text = "Wood " + str($"../Player".wood)
		$"."["visible"] = true
