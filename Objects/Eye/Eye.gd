tool
extends Node2D

export(bool) var is_unlocked : bool = false setget on_is_unlocked_changed

class_name Eye

signal on_unlocked

func _ready():
	on_is_unlocked_changed(false)
	
func on_is_unlocked_changed(value:bool):
	is_unlocked = value
	var anim = "open_eye" if is_unlocked else "idle"
	$AnimationPlayer.play(anim)
	
	if is_unlocked:
		emit_signal("on_unlocked")
	 