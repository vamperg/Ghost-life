extends PlayerState


export(NodePath) var _animation_player
onready var animation_player: AnimationPlayer = get_node(_animation_player)

func enter(_msg := {}) -> void:
	player.run_particles.emitting = true;
 
func physics_update(delta:float) -> void:
	if !player.life:
		state_machine.transition_to("Die")
	run_animate()
	
	if (player.get_move_direction() != Vector2.ZERO):
		player.velocity = player.velocity.move_toward(player.get_move_direction() * player.MAX_SPEED, player.ACCELERATION * delta)
	
	if (player.get_move_direction() == Vector2.ZERO):
		state_machine.transition_to("Idle")
		return
	
	player.velocity = player.move_and_slide(player.velocity);
	
	
	if player.in_object:
		if Input.is_action_pressed("ui_accept"):
			state_machine.transition_to("InObject")	

func run_animate():
	if player.get_move_direction().y < 0:
		animation_player.play("RunUp")
	elif player.get_move_direction().y > 0:
		animation_player.play("RunDown")
	elif player.is_rotate_right:
		animation_player.play("RunRight")
	else:
		animation_player.play("RunLeft")
