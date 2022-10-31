extends State
class_name PlayerState

var player: Player

func _ready() -> void:
	yield(owner, "ready")
	player = owner as Player
	assert(player != null)
