extends Node3D
var in_range = false
var opened = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if in_range:
		if Input.is_action_just_pressed("open") and opened == false:
			opened = true
			$"../Crafting_bench_ui"["visible"] = true
			$"../Player".release_mouse()
			print("opened")
		elif opened == true and Input.is_action_just_pressed("open"):
			$"../Crafting_bench_ui"["visible"] = false
			$"../Player".capture_mouse()
			print("closed")
			opened = false

	
func buy_house():
	if $"../Player".wood >= 5:
		$"../Player".wood = $"../Player".wood - 5
		$"../Label".text = "Wood " + str($"../Player".wood)
		$"../House"["visible"] = true

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		in_range = true
		$Label3D["visible"] = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		in_range = false
		$Label3D["visible"] = false
