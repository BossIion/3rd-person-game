extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func Forest() -> void:
	$"../Forest".grow_forest()


func House() -> void:
	$"../Crafting Table".buy_house()


func _on_bridge_pressed() -> void:
	$"../Bridge".build_bridge()
