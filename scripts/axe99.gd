extends Area3D

# Variable to hold the player's position relative to the key
var player: Node3D = null
var offset: Vector3 = Vector3(0, 0.5, -1)  # Adjust the offset as necessary
var is_picked_up = false
var axe_scene = preload("res://scenes/axe_99_projectile.tscn")
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
	if not is_picked_up:
		# Check if the player has a node to hold the item
		if player.has_node("ItemHolder"):
			var item_holder = player.get_node("ItemHolder")
			for i in item_holder.get_children():
				i.queue_free()
			self.reparent(item_holder)
			
			# Reset the position relative to the new parent
			self.position = Vector3.ZERO
			look_at(get_parent().get_parent().global_position)
			rotate(Vector3(0,1,0),90)
			is_picked_up = true
			# If the player has a pickup method, call it
		else:
			pass
		
func swing_axe():
	if Input.is_action_just_pressed("click"):
		$swing99.play("swing_99")
func _process(_delta):
	if is_picked_up == true:
		swing_axe()
		shoot()
	if player:
		# Continuously update the key's position relative to the player
		var target_position = player.global_transform.origin + player.global_transform.basis * offset
		global_transform.origin = target_position  # Update the key's position every frame
		
		
		
func shoot():
	if Input.is_action_just_pressed("right"):
		var axe_instance = axe_scene.instantiate()
		get_tree().root.add_child(axe_instance) # add the projectile
		axe_instance.global_position = %Projectile_spawn_point.global_position
		axe_instance.global_rotation = %Player.global_rotation
