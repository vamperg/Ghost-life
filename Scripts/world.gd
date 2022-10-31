extends Node2D

export(NodePath) var _pumpkin_bar
onready var pumpkin_bar: TextureProgress = get_node(_pumpkin_bar)

export(NodePath) var _ghost_container
onready var ghost_container: HBoxContainer = get_node(_ghost_container)



export(PackedScene) var ghost_count: PackedScene = null
var count_free_ghost = 0

export(Dictionary) var level_scene: Dictionary = {
	-1: "res://Scene/StartScene.tscn",
	0: "res://Scene/Tutorial.tscn",
	1: "res://Scene/Level2.tscn",
	2: "res://Scene/Level3.tscn"
}

func _ready():
	if count_free_ghost != 0:
		var item = ghost_count.instance()
		ghost_container.call_deferred("add_child", item)
	GlobalSignal.connect("ghostDie", self, "_onGhostDie")
	GlobalSignal.connect("startPumpkinBar", self, "_start_pumpkin_bar")
	GlobalSignal.connect("updatePumpkinBar", self, "_update_pumpkin_bar")
	GlobalSignal.connect("hidePumpkinBar", self, "_hidePumpkinBar")
	GlobalSignal.connect("freeGhost", self, "_update_ghost_count")
	GlobalSignal.connect("clearFreeGhost", self, "_clearFreeGhost")
	GlobalSignal.connect("levelFinished", self, "_levelFinished")
	GlobalSignal.connect("openSettings", self, "_open_settings")
	GlobalSignal.connect("exit", self, "_exit")
	
func _onGhostDie():
	get_tree().paused = true
	get_tree().reload_current_scene()
	get_tree().paused = false

func _start_pumpkin_bar(max_time):
	pumpkin_bar.visible = true
	pumpkin_bar.max_value = max_time
	pumpkin_bar.set_step(max_time/8)
	pumpkin_bar.value = max_time

func _update_pumpkin_bar(count):
	pumpkin_bar.set_value(count)
	if pumpkin_bar.value <0.1:
		pumpkin_bar.visible = false
func _hidePumpkinBar():
	pumpkin_bar.visible = false

func _update_ghost_count():
	count_free_ghost+=1
	var item = ghost_count.instance()
	ghost_container.call_deferred("add_child", item)
	
func _clearFreeGhost():
	count_free_ghost = 0
	for ghost_ico in ghost_container.get_children():
		ghost_ico.queue_free()

func _levelFinished(level:int):
	get_tree().change_scene(level_scene[level])
	

func _exit():
	get_tree().quit()
