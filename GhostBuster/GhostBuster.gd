extends KinematicBody2D

onready var animator = $AnimationPlayer

var speed = 15
var velocity
var target
var finish_target := false
var visible_ghost = false
onready var light2 := $Light2D3
export(Array,NodePath) var _point_position

onready var ray := $Ray
onready var rotate_timer := $Ray/RotateTimer
onready var ray_up := ray.get_node("RayUp")
onready var ray_down := ray.get_node("RayDown")
onready var ray_ghost := $RayGhost
onready var ray_timer := $RayGhost/Timer
onready var gun_particles :=$Light2D3/GunParticles

var ghost = null

var add_direction_ray = 0

var point_position:Array = []

var live = true



func _ready():
	randomize()
	for point in _point_position:
		if point:
			var pos = get_node(point)
			pos = pos.global_position
			point_position.append(pos)
			ray_direction()
			ray_rotate()
	GlobalSignal.connect("ghostlive", self, "_ghost_saving")
		
func ray_rotate():
	while live:
		rotate_timer.start(0.01); yield(rotate_timer, "timeout")
		if ghost != null:
			ray_ghost.rotation_degrees = (ghost.global_position-(global_position+$CollisionShape2D.position)).angle()*180/PI
		if ray_ghost.is_colliding() and visible_ghost and ghost != null:
			var coll = ray_ghost.get_collider().name
			if coll == "Player":
				gun_particles.emitting = true
				target = ghost.global_position
				finish_target = true
				ghost.die(self)
					
func ray_direction():
	while live:
		ray_timer.start(0.35); yield(ray_timer, "timeout")
		add_direction_ray = 0

		if ray_up.is_colliding():
			add_direction_ray = 90
		if ray_down.is_colliding():
			add_direction_ray = -90
		add_direction_ray = add_direction_ray * PI / 180

func _physics_process(delta):
	
	move(delta)
	animation()
	

func _on_Area2D_body_entered(body):
	if !body.in_object:
		visible_ghost = true
	

func move(delta):
	target = get_random_point()
	var new_dir
	if velocity != null:
		new_dir = velocity.normalized()
	else:
		new_dir = get_direction(target)
	var dir = get_direction(target)
	
	if !finish_target:
		new_dir = new_dir.move_toward(dir,3 * delta)
		ray.rotation_degrees = (new_dir.angle()*180/PI)
		
		light2.rotation_degrees = (new_dir.angle()*180/PI) + 90
		velocity = move_and_slide(new_dir * 90 * speed * delta)
		
	else:
		velocity = Vector2.ZERO
		new_dir = new_dir.move_toward(dir,3 * delta)
		ray.rotation_degrees = (new_dir.angle()*180/PI)
		
		light2.rotation_degrees = (new_dir.angle()*180/PI) + 90
func get_random_point():
	randomize()
	if target == null:
		var rnd = randi() % point_position.size()
		return point_position[rnd]
	else:
		if global_position.distance_to(target) < 3:
			var rnd = randi() % point_position.size()
			while point_position[rnd] == target:
				rnd = randi() % point_position.size()
			return point_position[rnd]
		else:
			return target

func get_direction(position: Vector2):
	var dir:Vector2
	if target == null:
		dir = global_position.direction_to(ghost.global_position)
	else:
		dir = global_position.direction_to(target)
		dir = dir.rotated(add_direction_ray)
	return dir

func animation():
	var dir = velocity.normalized()
	if dir.x == 0 and dir.y == 0:
		animator.stop()
	elif dir.x > -0.5 and dir.x < 0.5:
		if dir.y > 0: 
			animator.play("WalkDown")
		else:
			animator.play("WalkUp")
	elif dir.x > 0: 
		if dir.y <0.5 and dir.y>-0.5:
			animator.play("WalkRight")
		elif dir.y < 0:
			animator.play("WalkUpRight")
		elif dir.y > 0:
			animator.play("WalkDownRight")
	
	elif dir.x < 0:

		if dir.y <0.5 and dir.y>-0.5:
			animator.play("WalkLeft")
		elif dir.y < 0:
			animator.play("WalkUpLeft")
		elif dir.y > 0:
			animator.play("WalkDownLeft")
			
	

		


func _on_GhostDetect_body_entered(body):
	ghost = body


func _on_AreaGhostLight_body_exited(body):
	visible_ghost = false

func _ghost_saving():
	ghost = null
	visible_ghost = false
	finish_target = false

	gun_particles.emitting = false
