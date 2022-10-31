class_name Pumpkin
extends StaticBody2D

onready var destruct_timer = $DestructTimer
onready var sprite := $Sprite
const LIFE_TIME = 10.0
const TIME_LEFT = 0.05
var die := false


export(PackedScene) var pumpkin_part: PackedScene = null

func destruction():
	sprite.frame = 1
	GlobalSignal.emit_signal("startPumpkinBar",LIFE_TIME)
	die = true
	var life_time = LIFE_TIME
	while (life_time>=0):
		destruct_timer.start(0.05); yield(destruct_timer, "timeout")
		life_time -= TIME_LEFT
		GlobalSignal.emit_signal("updatePumpkinBar",life_time)
	for i in randi() % 25+10:
		Spawn_item(pumpkin_part)
	queue_free()

func Spawn_item(pumpkin_part: PackedScene, effect_position: Vector2 = global_position):
	if pumpkin_part:
		var item:FakeHeightObject = pumpkin_part.instance()
		get_parent().add_child(item)
		item.global_position = effect_position
		item.initialize(Vector2(rand_range(-1,1)+0.1, rand_range(-1,1)+0.1)*20, rand_range(10,20)*4)

func Destroy():
	GlobalSignal.emit_signal("hidePumpkinBar")
	for i in randi() % 25+10:
		Spawn_item(pumpkin_part)
	queue_free()
