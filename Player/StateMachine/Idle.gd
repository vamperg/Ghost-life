extends PlayerState

export(NodePath) var _animation_player
onready var animation_player: AnimationPlayer = get_node(_animation_player)

func enter(_msg := {}) -> void:
	player.run_particles.emitting = false;
	animation_player.play("Idle")

 
func physics_update(delta:float) -> void:
	if !player.life:
		state_machine.transition_to("Die")
	if (player.get_move_direction() != Vector2.ZERO):
		state_machine.transition_to("Run")
		return
	player.velocity = player.velocity.move_toward(Vector2.ZERO, player.FRICTION * delta)
	player.velocity = player.move_and_slide(player.velocity);
	
	if player.in_object:
		if Input.is_action_pressed("ui_accept"):
			state_machine.transition_to("InObject")
