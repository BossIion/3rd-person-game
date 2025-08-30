extends Area3D

# Variable to hold the player's position relative to the key
var player: Node3D = null
var offset: Vector3 = Vector3(0, 0.5, -1)  # Adjust the offset as necessary
var is_picked_up = false
# Called when the node enters the scene tree for the first time
func _ready():
	body_entered.connect(_on_body_entered)
# Called when a body enters the area
func _on_body_entered(body):
	if body.name == "Player":  # Check if the body is the player
		call_deferred("pickup_item", body)  # Call deferred function to pickup the key



func pickup_item(player):
	if not player:
		return
	
	# Check if the player has a node to hold the item
	if player.has_node("ItemHolder"):
		var item_holder = player.get_node("ItemHolder")
		self.reparent(item_holder)
		
		# Reset the position relative to the new parent
		self.position = Vector3.ZERO
		is_picked_up = true
		# If the player has a pickup method, call it
	else:
		pass
		
func swing_axe():
	if Input.is_action_just_pressed("click"):
		$AnimationPlayer2.play("Axe_SWING")
func _process(_delta):
	if is_picked_up == true:
		swing_axe()
	if player:
		# Continuously update the key's position relative to the player
		var target_position = player.global_transform.origin + player.global_transform.basis * offset
		global_transform.origin = target_position  # Update the key's position every frame
