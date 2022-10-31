extends Node2D

export(PackedScene) var ghost_trap_part: PackedScene = null
export(PackedScene) var ghost_in: PackedScene = null
export var is_tutorial: bool = false
var player
onready var break_particle = $BreakParticles

func _on_ghost_entered(body):
	player = body
	if !is_tutorial:
		Spawn_ghost(ghost_in)
	for i in randi() % 6+3:
		Spawn_item(ghost_trap_part)
	break_particle.emitting = true
	$Sprite.visible = false
	$Sprite2.visible = false
	yield(get_tree().create_timer(2),"timeout")
	queue_free()


func Spawn_item(ghost_trap_part: PackedScene, effect_position: Vector2 = global_position):
	if ghost_trap_part:
		var item:FakeHeightObject = ghost_trap_part.instance()
		get_parent().call_deferred("add_child", item)
		item.global_position = effect_position
		item.initialize(Vector2(rand_range(-1,1)+0.1, rand_range(-1,1)+0.1)*20, rand_range(10,20)*4)

func Spawn_ghost(ghost: PackedScene, ghost_position: Vector2 = global_position):
	if ghost:
		var item:Ghost = ghost_in.instance()
		get_parent().call_deferred("add_child", item)
		item.global_position = ghost_position
		item.player = self.player
