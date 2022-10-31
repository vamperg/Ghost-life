extends FakeHeightObject

var time_destruct := 0.0
onready var timer := $Timer

func _ready():
	trns_body = $Sprite
	trns_shadow = $Shadow
	trns_body.rotation_degrees = randi() % 360
	randomize()
	time_destruct = rand_range(4,9)
	_timer_destuct()

func _on_StarItem_on_ground_hit_signal():
	bounce(1.6)
	slow_down_ground_velocity(1.4)

func _timer_destuct():
	timer.start(time_destruct); yield(timer, "timeout")
	queue_free()
