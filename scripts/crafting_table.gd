extends Node3D
var in_range = false
var opened = false
# Called when the node enters the scene tree for the first time.
@onready var csg_baked_collision_shape_3d_2: CollisionShape3D = $"../House".get_child(1).get_child(0)

@onready var csg_box_3d_2: CSGBox3D = $"../House/DoorHinge/CSGBox3D2"

func _ready() -> void:
	csg_baked_collision_shape_3d_2.disabled = true
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if in_range:
		if Input.is_action_just_pressed("open") and opened == false:
			opened = true
			$"../../Crafting_bench_ui"["visible"] = true
			$"../../Player".release_mouse()
			print("opened")
		elif opened == true and Input.is_action_just_pressed("open"):
			$"../../Crafting_bench_ui"["visible"] = false
			$"../../Player".capture_mouse()
			print("closed")
			opened = false

	
func buy_house():
	csg_baked_collision_shape_3d_2.disabled = false
	csg_box_3d_2["use_collision"] = true
	if $"../../Player".wood >= 3:
		$"../../Player".wood = $"../../Player".wood - 3
		$"../../Label".text = "Wood " + str($"../../Player".wood)
		$"../House"["visible"] = true

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		in_range = true
		$Label3D["visible"] = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		in_range = false
		$Label3D["visible"] = false
