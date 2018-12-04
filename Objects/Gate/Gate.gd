extends KinematicBody2D

var unlocked_eye_amount = 0

var is_gate_unlocked = false setget on_is_gate_unlocked_changed
signal on_gate_unlock

export(int) var move_to_pos_y = -350
export(float) var duration = 2

export(NodePath) var eyes = []

var eye_count = 0

func _ready():
	init_eyes()


func init_eyes():
	for i in get_children():
		if i.is_in_group("eye"):
			attach_eye(i)

func attach_eye(eye):
	eye_count += 1
	eye.connect("on_unlocked", self, "on_eye_unlocked")


func on_eye_unlocked():
	unlocked_eye_amount += 1
	if unlocked_eye_amount >= eye_count:
		on_is_gate_unlocked_changed(true)


func on_is_gate_unlocked_changed(value):
	is_gate_unlocked = value
	if is_gate_unlocked:
		$Timer.start(1)
		yield($Timer, "timeout")
		emit_signal("on_gate_unlock")
		move_gate()


func move_gate():
	$Tween.interpolate_property(self, "position", position, position + Vector2(0, move_to_pos_y), duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	yield($Tween, "tween_completed")
	print("Tween Finished")