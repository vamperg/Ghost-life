extends Node2D


func _ready():
	pass


func _on_ghost_entered(body):
	body.die(self)
