extends Node


func _pressed():
	if name == "FullScreen":
		OS.set_window_fullscreen(!OS.window_fullscreen)
		return
	var node = get_node("../Slider")
	if name == "Minus":
		node.set_value(node.get_value() - node.step)
	else:
		node.set_value(node.get_value() + node.step)
		
	var db_value = node.value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(get_node("../").name), db_value)

