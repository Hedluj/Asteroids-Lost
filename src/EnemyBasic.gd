extends Area2D

var movement = Vector2.ZERO
var speed = 500


func _on_EnemyBasic_body_entered(body):
	if body.is_in_group("player_bullet"):
		queue_free()
