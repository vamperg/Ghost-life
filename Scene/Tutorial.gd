extends Node2D

export(Array,NodePath) var _tutorial_stage_pos
export(Array,NodePath) var _tutorial_message
onready var tutorial_message:Array
var stage_pos:Array
var stage = 0
func _ready():
	for pos in _tutorial_stage_pos:
		stage_pos.append(get_node(pos).global_position)
	for mess in _tutorial_message:
		tutorial_message.append(get_node(mess))
	tutorial_message[0].call_deferred("activate_label")

func _physics_process(delta):
	if stage < _tutorial_stage_pos.size():
		if global_position.distance_to(stage_pos[stage]) < 30:
			tutorial_message[stage].visible = false
			stage +=1
			if stage < _tutorial_stage_pos.size():
				tutorial_message[stage].visible = true
				tutorial_message[stage].call_deferred("activate_label")
