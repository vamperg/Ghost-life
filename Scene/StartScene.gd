extends Node2D


export(NodePath) var _settings
onready var settings: Control = get_node(_settings)

export(Dictionary) var level_scene: Dictionary = {
	0: "res://Scene/Tutorial.tscn",
	1: "res://Scene/Level2.tscn"
}

func _ready():
	GlobalSignal.connect("openSettings", self, "_open_settings")
	GlobalSignal.connect("levelFinished", self, "_levelFinished")

func _open_settings():
	if settings.visible:
		settings.visible = false
	else:
		settings.visible = true
		
func _levelFinished(level:int):
	get_tree().change_scene(level_scene[level])
