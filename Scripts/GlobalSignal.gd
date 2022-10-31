extends Node

signal ghostlive()
signal ghostDie()
signal levelFinished(level)

signal startPumpkinBar(max_time)
signal updatePumpkinBar(value)
signal hidePumpkinBar()

signal freeGhost()
signal clearFreeGhost()

signal openSettings()
signal exit()

var exit_menu = preload("res://Exit.tscn")

func _process(delta):
	if Input.is_action_just_pressed("ui_exit"):
		if !has_node("/root/ExitMenu"):
			var item = exit_menu.instance()
			get_parent().call_deferred("add_child", item)
		else:
			get_node("/root/ExitMenu").queue_free()
