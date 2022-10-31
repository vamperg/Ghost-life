extends Label

signal finish_text()
onready var timer := $Timer
export (Array,String) var text_array
export (float) var typing_speed = 0.1
export (float) var wait_phrase = 2
var current_text := 0


func _ready():
	visible_characters = -1
	text = ""
	
func activate_label():
	if text_array.size() < 1:
		return
	current_text = 0
	var current_char = 0
	var phrase = text_array[current_text]
	while current_text <= text_array.size():
		timer.start(typing_speed); yield(timer, "timeout")
		if phrase[current_char] == "/":
			text += "\n"
		else:
			text += phrase[current_char]
		if current_char >= phrase.length()-1:
			if current_text+1 != text_array.size():
				current_text +=1
				current_char = -1
				timer.start(wait_phrase); yield(timer, "timeout")
				phrase = text_array[current_text]
				text = ""
			else:
				break
		current_char +=1
	timer.start(wait_phrase); yield(timer, "timeout")
	hide_label()

func hide_label():
	visible = false
	emit_signal("finish_text")
