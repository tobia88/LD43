extends KinematicBody2D

const MOVE_SPEED_X = 200
const GRAVITY = 1600
const MIN_JUMP_FORCE = 600
const MAX_JUMP_FORCE = 1000
var input = Vector2()
var velocity = Vector2()
var is_grounded = false

class_name Player


func _physics_process(delta):
	controls_loop()
	movement_loop(delta)


func controls_loop():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var JUMP = Input.is_action_just_pressed("ui_up") and is_grounded
	var RELEASE_JUMP = Input.is_action_just_released("ui_up")

	input.x = -int(LEFT) + int(RIGHT)

	if JUMP:
		velocity.y = -MAX_JUMP_FORCE
	elif RELEASE_JUMP and velocity.y < -MIN_JUMP_FORCE:
		velocity.y = -MIN_JUMP_FORCE


func dead():
	queue_free()


func movement_loop(delta):
	velocity.x = input.x * MOVE_SPEED_X

	if input.x < 0:
		$Body.scale.x = -1
	elif input.x > 0:
		$Body.scale.x = 1

	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity, Vector2(0, 1))
	is_grounded = velocity.y == 0