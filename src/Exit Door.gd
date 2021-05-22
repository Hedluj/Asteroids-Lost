extends Area2D

signal leaving_level
const Player = preload("res://src/Player.tscn")

func _on_Exit_Door_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("leaving_level")
