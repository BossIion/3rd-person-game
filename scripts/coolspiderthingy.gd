extends Node3D

@export var move_speed: float = 10.0
@export var turn_speed: float = 2.0
@export var ground_offset: float = 0.5
@onready var player: CharacterBody3D = $"../Player"
@onready var NavAgent = $NavigationAgent3D
@onready var left_center_down: Marker3D = $LeftCenterDown
@onready var left_down: Marker3D = $LeftDown
@onready var left_up: Marker3D = $LeftUp
@onready var right_center_up: Marker3D = $RightCenterUp
@onready var left_center_up: Marker3D = $LeftCenterUp
@onready var right_down: Marker3D = $RightDown
@onready var right_center_down: Marker3D = $RightCenterDown
@onready var right_up: Marker3D = $RightUp

func _process(delta):
	var plane1 = Plane(left_down.global_position, left_up.global_position, right_up.global_position)
	var plane2 = Plane(right_up.global_position, right_down.global_position, left_down.global_position)
	var avg_normal = ((plane1.normal + plane2.normal) / 2).normalized()
	
	var target_basis = _basis_from_normal(avg_normal)
	transform.basis = lerp(transform.basis.orthonormalized(), target_basis.orthonormalized(), move_speed * delta).orthonormalized()
	
	var avg = (left_up.position + right_up.position + left_down.position + right_down.position) /4
	var target_pos = avg + transform.basis.y * ground_offset
	var distance = transform.basis.y.dot(target_pos - position)
	position = lerp(position, position + transform.basis.y * distance, move_speed * delta)
	
	_handle_movement(delta)
	
func _handle_movement(delta):
	NavAgent.set_target_position(player.position)
	var destination = NavAgent.get_next_path_position()
	var local_destination = destination - global_position
	var dir = local_destination.normalized()
	
	translate(Vector3(dir[0], 0, dir[2]) * move_speed * delta)
	#var a_dir = global_position.angle_to(player.global_position) - 0.5
	#rotate_object_local(Vector3.UP, a_dir * turn_speed * delta)
	print(local_destination)
	if abs(local_destination[0]) > 0.5:
		$Armature.look_at(player.global_position)
	
func _basis_from_normal(normal: Vector3) -> Basis:
	var result = Basis()
	result.x = normal.cross(transform.basis.z)
	if result.x.x == 0:
		result.x.x = 0.01
	if result.x.y == 0:
		result.x.y = 0.01
	if result.x.z == 0:
		result.x.z = 0.01
	result.y = normal
	if result.y.x == 0:
		result.y.x = 0.01
	if result.y.y == 0:
		result.y.y = 0.01
	if result.y.z == 0:
		result.y.z = 0.01
	result.z = transform.basis.x.cross(normal)
	if result.z.x == 0:
		result.z.x = 0.01
	if result.z.y == 0:
		result.z.y = 0.01
	if result.z.z == 0:
		result.z.z = 0.01
	if scale.x == 0:
		scale.x = 0.01
	if scale.y == 0:
		scale.y = 0.01
	if scale.z == 0:
		scale.z = 0.01
	result.x *= scale.x
	result.y *= scale.y
	result.z *= scale.z
	
	return result
	
	
func die(body):
	if body.name == "Player":
		var root = get_tree().get_root()
		var screen = $"../Death_Screen"
		screen.visible = true
		await get_tree().create_timer(2).timeout
		screen.visible = false
		get_tree().reload_current_scene()
		if Input.is_anything_pressed() == true:
			pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	die(body)
