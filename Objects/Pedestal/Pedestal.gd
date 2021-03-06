extends Area2D

onready var goddess : Goddess = $Goddess 

var is_active : bool = false setget on_is_active_changed

export(NodePath) var test

func _ready():
	$Body.modulate = Global.Dark()
	
func on_is_active_changed(value:bool):
	is_active = value
	goddess.show()
	var eye = get_node(test) as Eye
	eye.is_unlocked = true

func _on_Pedestal_area_entered(area:Node2D):
	if is_active:
		return
		
	if area.is_in_group("ghost"):
		on_is_active_changed(true)