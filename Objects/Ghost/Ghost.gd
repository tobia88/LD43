extends Area2D


const DETECT_RADIUS = 100
const FLOAT_SPEED = 1
const MAX_SPEED = 1
const DEBUG_COLOR = Color(1, 0, 0, 0.5)

export var test = Vector2(0, 0)

var player = null setget on_set_player
var velocity = Vector2()

class_name Ghost


func on_set_player(p:Player):
	player = p


func _process(delta):
	if player == null:
		return

	move_toward_player(delta)


func dead():
	queue_free()


func move_toward_player(delta):
	var dist : Vector2 = self.player.position - position
	velocity += dist.normalized() * FLOAT_SPEED	* delta
	velocity = velocity.clamped(MAX_SPEED)

	if velocity.x < -0:
		scale.x = -1
	elif velocity.x > 0:
		scale.x = 1

	position += velocity