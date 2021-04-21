extends KinematicBody2D

onready var firingpositions = $FiringPositions

var input_vector = Vector2.ZERO
var velocity = Vector2.ZERO

var plBullet = preload("res://src/Bullet.tscn")
var can_fire = true

export var acceleration = 600
export var max_speed = 450
export var bullet_speed = 1000
export var fire_rate = 0.2

var roatation_direction : int
export var rotation_speed = 3.5

export var friction_weight = 0.025

func _process(delta):
	
	if Input.is_action_pressed("shoot") and can_fire:
		for child in firingpositions.get_children():
			
			var bullet_instance = plBullet.instance()
			bullet_instance.position = $"FiringPositions/FrontGun".get_global_position()
			bullet_instance.rotation_degrees = rotation_degrees
			bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed,0).rotated(rotation))
			get_tree().get_root().add_child(bullet_instance)
			can_fire = false
			yield(get_tree().create_timer(fire_rate), "timeout")
			can_fire = true 

func _physics_process(delta):
	
	input_vector.x = Input.get_action_strength("move_forward")-Input.get_action_strength("move_back")
	roatation_direction = 0
	if Input.get_action_strength("strafe_left"):
		roatation_direction += 1
	elif Input.get_action_strength("strafe_right"):
		roatation_direction += -1
	
	if input_vector.x == 0 && velocity != Vector2.ZERO:
		velocity = lerp(velocity, Vector2.ZERO, friction_weight)
		if abs(velocity.x) <= 0.1:
			velocity.x = 0
		if abs(velocity.y) <= 0.1:
			velocity.y = 0
	
	velocity += Vector2(input_vector.x * acceleration  * delta, 0).rotated(rotation)
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	velocity.y = clamp(velocity.y, -max_speed, max_speed)
	
	rotation += roatation_direction * rotation_speed * delta
	velocity = move_and_slide(velocity)
	
