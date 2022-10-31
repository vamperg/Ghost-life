extends Node2D

class_name FakeHeightObject

signal on_ground_hit_signal

var trns_object
var trns_body
var trns_shadow

var body_size
var shadow_size

var gravity: float = -200
var ground_velocity: Vector2
var verticle_velocity: float
var last_init_verticle_velocity: float

var is_grounded: bool = false

func _physics_process(delta):
	update_position(delta)
	check_ground_hit()
	
# Определение скорости и начало движения
func initialize(ground_velocity:Vector2, vertical_position:float) -> void: 
	self.is_grounded = false
	self.ground_velocity = ground_velocity
	self.verticle_velocity = vertical_position
	self.last_init_verticle_velocity = self.verticle_velocity
	if ground_velocity.length() < 1:
		stick()

func update_position(delta) -> void:
	if !is_grounded:
		verticle_velocity += gravity * delta
		trns_body.position += Vector2(0, -verticle_velocity) * delta*2
	global_position += ground_velocity * delta

func check_ground_hit() -> void:
	if trns_body.global_position.y > global_position.y and !is_grounded:
		trns_body.global_position = global_position
		is_grounded = true
		ground_hit()

func ground_hit() -> void:
	emit_signal("on_ground_hit_signal")

func stick() -> void:
	ground_velocity = Vector2.ZERO
	is_grounded = true
	
func bounce(division_factor:float) -> void:
	initialize(ground_velocity, last_init_verticle_velocity / division_factor)

func slow_down_ground_velocity(division_factor:float) -> void:
	ground_velocity = ground_velocity / division_factor
	
	
