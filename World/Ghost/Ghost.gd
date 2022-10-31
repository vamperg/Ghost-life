class_name Ghost

extends KinematicBody2D

var ghost_take = false
onready var animator_player := $AnimationPlayer
onready var anim_label := $Label
export (Array, String) var dialog_text
var speed = 100
var player = null
var dir := Vector2.ZERO
var go_player := false
func _ready():
	anim_label.connect("finish_text" , self, "go_to_player")

func _physics_process(delta):
	if !go_player:
		return
	dir = global_position.direction_to(player.global_position)
	move_and_slide(dir * speed * 60 * delta)
	if global_position.distance_to(player.global_position) < 5:
		GlobalSignal.emit_signal("freeGhost")
		queue_free()

func show_message():
	animator_player.play("Idle")
	anim_label.text_array = dialog_text
	anim_label.activate_label()

func go_to_player():
	if player != null:
		animator_player.play("InObject")
		yield(get_tree().create_timer(0.4),"timeout")
		go_player = true
		ghost_take = true
		

func _on_Area2D_ghost_entered(body):
	self.player = body
