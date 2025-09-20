extends Area3D

# A variable to hold a reference to the axe node when it's detected
var axe_in_range = false
var animaton_finished = false
signal addWood(wood: int)
func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(node):
	# This signal is only called when a body enters the area.
	print("area entered")
	if node.name == "Axe":
		print("Axe detected")
		axe_in_range = true

func _on_area_exited(node):
	# It's good practice to also handle when a body exits the area.
	if node.name == "Axe":
		print("Axe exited")
		axe_in_range = false

func _process(_delta):
	# Check for input every frame, but only if the axe is in range.
	if axe_in_range and Input.is_action_just_pressed("click"):
		print("clicked")
		if animaton_finished == false:
			# Assuming the AnimationPlayer is a child of the current node
			$AnimationPlayer.play("Tree_Fall")
			animaton_finished = true

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	addWood.emit(3)
	queue_free()
