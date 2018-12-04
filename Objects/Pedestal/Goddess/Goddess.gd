extends Area2D

class_name Goddess

var is_active = false

onready var light : RevealLight =  $RevealLight

var value : Array = []

func _ready():
	visible = false
	light.visible = false
	monitoring = false

func show():
	is_active = true
	light.visible = true
	visible = true
	monitoring = true
	$AnimationPlayer.play("show")
	yield($AnimationPlayer, "animation_finished")
	value = [$Body.position, $Body.position + Vector2(0, 50)]
	start_tween()



func _on_Goddess_area_entered(area:Node2D):
	if area.is_in_group("ghost"):
		print("Purify By Goddess")
		var ghost = area as Ghost
		ghost.on_purify()


func start_tween():
	$Tween.interpolate_property($Body, "position", value[0], value[1], 2, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Tween.start()


func _on_Tween_tween_completed(object, key):
	value.invert()
	start_tween()
