extends PlayerState


export(NodePath) var _animation_player
export(NodePath) var _timer
export(NodePath) var _ghost_save_particle
onready var animation_player: AnimationPlayer = get_node(_animation_player)
onready var timer: Timer = get_node(_timer)
onready var ghost_save_particle: Particles2D = get_node(_ghost_save_particle)

func enter(_msg := {}) -> void:
	player.run_particles.emitting = true;
	animation_player.play("InObject")
	if get_tree().get_current_scene().count_free_ghost >= 3:
		ghost_save_particle.emitting = true
		GlobalSignal.emit_signal("ghostlive")
		state_machine.transition_to("Idle")
		player.life = true
		GlobalSignal.emit_signal("clearFreeGhost")

 
func physics_update(delta:float) -> void:
	if player.visible == false:
		return
	if player.global_position.distance_to(player.ghost_busters.global_position) < 5:
		player.visible = false
		timer.start(1); yield(timer, "timeout")
		GlobalSignal.emit_signal("ghostDie")
	else:
		player.velocity = player.velocity.move_toward((player.global_position.direction_to(player.ghost_busters.global_position)) * player.MAX_SPEED, player.ACCELERATION * delta)
		player.move_and_slide(player.velocity);
