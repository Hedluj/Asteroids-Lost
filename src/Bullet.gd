extends RigidBody2D



func _on_Bullet_body_entered(body):
	if !body.is_in_group("player") or body.is_in_group("enemy"):
		queue_free()
