extends DirectionalLight3D
@onready var sun = $"."
@onready var moon = $"../DirectionalLight_Ambient"
@onready var timer = $"../../Timer"
var day = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()
	$AnimationPlayer.play("sun_rise_set")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	print("timer ended")
	day = not day
	if day:
		sun.light_energy = 7.0
		moon.light_energy = 0.1
	else:
		sun.light_energy = 0.1
		moon.light_energy = 7.0	
	
