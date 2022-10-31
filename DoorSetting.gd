extends Node2D


func _ready():
	pass
func _on_Area_body_entered(body):
	GlobalSignal.emit_signal("openSettings")


func _on_Area_body_exited(body):
	GlobalSignal.emit_signal("openSettings")
