extends PlayerState


export(NodePath) var _animation_player
export(NodePath) var _player_sprite
onready var animation_player: AnimationPlayer = get_node(_animation_player)
onready var player_sprite: Sprite = get_node(_player_sprite)

var speed = 500

func enter(_msg := {}) -> void:
	player.run_particles.emitting = true;
	animation_player.play("InObject")
	player.pumpkin.destruction()
 
func physics_update(delta:float) -> void:
	if player.global_position.distance_to(player.object_position)>2:
		var dir = player.global_position.direction_to(player.object_position)
		player.move_and_slide(dir * speed * 10 * delta)
	else:
		player.run_particles.emitting = false;
		player.set_visible(false)
		
	if player.in_object:
		if Input.is_action_just_pressed("ui_accept"):
			player.set_visible(true)
			player.in_object = false
			player.pumpkin.Destroy()
			state_machine.transition_to("Idle")
			
	else:
		player.set_visible(true)
		state_machine.transition_to("Idle")

