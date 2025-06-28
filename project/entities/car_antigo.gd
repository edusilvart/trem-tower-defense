extends CharacterBody2D

# References
@onready var parent : CharacterBody2D = get_parent()
@onready var sprite : Node2D = get_node('SpriteStack')

var wheels_distance = 11
var steering_angle = 15
var engine_power = 150
var friction = -0.1
var drag = -0.001
var braking = 250
var maxSpeedReverse = 100
var slip_speed = 100
var traction_fast = 0.05
var traction_slow = 0.07

var acceleration = Vector2()
var steering_direction = 0

var mass = 50
var height = 1
var inAir = false

func _process(delta):
	acceleration = Vector2.ZERO
	_update_inputs()
	_apply_friction()
	_calculate_steering(delta)
	velocity += acceleration * delta

func _apply_friction():
	if velocity.length() < 1:
		velocity = Vector2.ZERO
	var frictionForce = velocity * friction
	var dragForce = velocity * velocity.length() * drag
	acceleration += dragForce + frictionForce

func add_speed(speed : float):
	acceleration = transform.x * engine_power

func _update_inputs():
	var turn = 0
	
	if Input.is_action_pressed("left"):
		turn -= 1
	elif Input.is_action_pressed("right"):
		turn += 1
	steering_direction = turn * deg_to_rad(steering_angle)
	print(steering_direction)
	if Input.is_action_pressed("up"):
		acceleration = transform.x * engine_power
	elif Input.is_action_pressed("down"):
		acceleration = -transform.x * braking

func _calculate_steering(delta):
	var rearWheel = position - transform.x * wheels_distance/2
	var frontWheel = position + transform.x * wheels_distance/2
	
	rearWheel += velocity * delta
	frontWheel += velocity.rotated(steering_direction) * delta
	
	var new_heading = (frontWheel - rearWheel).normalized()
	var traction = traction_slow
	if velocity.length() > slip_speed:
		traction = traction_fast
	var d = new_heading.dot(velocity.normalized())
	if d > 0:
		velocity = velocity.lerp(new_heading * velocity.length(), traction * delta)
	if d < 0:
		velocity = -new_heading * min(velocity.length(), maxSpeedReverse)
	rotation = new_heading.angle()
	sprite.rot = rotation
	hurtbox.rotation = rotation
	collision.rotation = rotation
	shadow.rotation = rotation
