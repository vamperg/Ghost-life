class_name Player
extends KinematicBody2D

const ACCELERATION = 700
const MAX_SPEED = 90
const FRICTION = 300

var life = true
var ghost_busters

var velocity = Vector2.ZERO
var is_rotate_right = true

var in_object: bool = false
var object_position:Vector2
var pumpkin

var take_ghost = 0

export(NodePath) onready var sprite = $Sprite
onready var run_particles = $RunParticle

var input_vector = Vector2.ZERO

func _ready():
	pass


func get_move_direction():
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized();
	if input_vector.x > 0:
		is_rotate_right = true
	elif input_vector.x < 0:
		is_rotate_right = false
	return input_vector



func _on_Area2D_body_entered(body):
	if body is Ghost:
		take_ghost +=1
	print("pup")
	if body is Pumpkin:
		print("pup")
		if body.die == false:
			object_position = body.global_position
			in_object = true
			pumpkin = body
	
	
func die(_ghost_busters):
	life = false
	self.ghost_busters = _ghost_busters
			

func _on_Area2D_body_exited(body):
	if body is Pumpkin:
		in_object = false
