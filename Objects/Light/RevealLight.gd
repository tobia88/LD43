extends Light2D

class_name RevealLight

tool

export(float, 0, 10) var LIGHT_SIZE : float = 5 setget on_light_size_changed

func on_light_size_changed(value):
	if not Engine.editor_hint:
		return
		
	LIGHT_SIZE = value
	self.texture_scale = LIGHT_SIZE
	$body.scale = Vector2(LIGHT_SIZE, LIGHT_SIZE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
