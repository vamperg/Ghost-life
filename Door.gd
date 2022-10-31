extends Node2D

export (int) var next_level

func _ready():
	pass


func _on_Area_body_entered(body):
	GlobalSignal.emit_signal("levelFinished", next_level)
