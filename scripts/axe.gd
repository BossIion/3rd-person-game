extends Area3D

# Variable to hold the player's position relative to the key
var player: Node3D = null
var offset: Vector3 = Vector3(0, 0.5, -1)  # Adjust the offset as necessary

# Called when the node enters the scene tree for the first time
func _ready():
	body_entered.connect(_on_body_entered)
	print("ready")
# Called when a body enters the area
func _on_body_entered(body):
	print("body entered")
	if body.name == "Player":  # Check if the body is the player
		print("Body detected")
		call_deferred("_pickup_axe", body)  # Call deferred function to pickup the key



func _pickup_axe(body):
	if not body:
		return
	player = body
	set_as_top_level(true) 
	get_parent().remove_child(self)
	body.add_child(self) 
	if body.has_method("pickup_axe"):
		body.pickup_axe()  
		
		
func _process(_delta):
	if player:
		# Continuously update the key's position relative to the player
		var target_position = player.global_transform.origin + player.global_transform.basis * offset
		global_transform.origin = target_position  # Update the key's position every frame
