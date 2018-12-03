extends Area2D

class_name Goddess

var is_active = false

onready var light : RevealLight =  $RevealLight

func _ready():
	visible = false
	light.visible = false
	monitoring = false

func show():
	is_active = true
	light.visible = true
	visible = true
	monitoring = true
	

func _on_Goddess_area_entered(area:Node2D):
	if area.is_in_group("ghost"):
		print("Purify By Goddess")
		var ghost = area as Ghost
		ghost.on_purify()