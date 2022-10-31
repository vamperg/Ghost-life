extends CanvasLayer


func _ready():
	pass


func _on_Button_pressed():
	GlobalSignal.emit_signal("exit")
