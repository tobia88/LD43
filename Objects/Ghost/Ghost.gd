extends Area2D


const DETECT_RADIUS = 100
const FLOAT_SPEED = 1
const MAX_SPEED = 1
const DEBUG_COLOR = Color(1, 0, 0, 0.5)

var player = null
var velocity = Vector2()

class_name Ghost

signal on_dead(ghost)


func _process(delta):
	if not self.player:
		return

	move_toward_player(delta)


func on_purify():
	print("on purify")
	dead()
	

func dead():
	visible = false
	emit_signal("on_dead", self)
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
	

func _on_Ghost_body_entered(body):
	if body.is_in_group("Player"):
		body.on_ghost_cover(self)


func _on_Ghost_body_exited(body):
	if body.is_in_group("Player"):
		body.on_ghost_leave(self)
