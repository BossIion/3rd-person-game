extends Node3D


signal addWood(wood: int)

func addWoodPlayer(amtWood):
	addWood.emit(3)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func grow_forest():
	if $"../Player".wood >= 4:
		$"../Player".wood = $"../Player".wood - 4
		$"../Label".text = "Wood " + str($"../Player".wood)
		$"."["visible"] = true
