extends Light2D

const MAX_SCALE = 1
const MIN_SCALE = 0.95
var STATIC_SPEED = 0.4
var is_strength = true;
var current_energy = MIN_SCALE
onready var light2 = $Light2D2
 
func _ready():
	STATIC_SPEED = rand_range(0.3,0.5)
	set_energy(current_energy)
	if light2 !=null:
		light2.set_energy(current_energy)

func _physics_process(delta):
	current_energy = get_energy()
	if is_strength:
		current_energy = move_toward(current_energy, MAX_SCALE, delta * STATIC_SPEED)
		if current_energy == MAX_SCALE:
			is_strength = false
			
	else:
		current_energy = move_toward(current_energy, MIN_SCALE, delta * STATIC_SPEED)
		if current_energy == MIN_SCALE:
			is_strength = true
	
	
	set_energy(current_energy)
	if light2 !=null:
		light2.set_energy(current_energy)
