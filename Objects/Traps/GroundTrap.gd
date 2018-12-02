extends Area2D

class_name GroundTrap

signal on_player_enter

func _on_GroundTrap_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("on_player_enter")