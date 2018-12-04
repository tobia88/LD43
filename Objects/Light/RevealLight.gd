tool

extends Light2D

class_name RevealLight

export(float, 0, 10) var LIGHT_SIZE : float = 5 setget on_light_size_changed
export(Color) var LIGHT_COLOR : Color = Color.yellow setget on_light_color_changed

func on_light_size_changed(value):
	LIGHT_SIZE = value
	
	texture_scale = LIGHT_SIZE
	$body.scale = Vector2(LIGHT_SIZE, LIGHT_SIZE)
	

func on_light_color_changed(value):
	LIGHT_COLOR = value
	
	color = LIGHT_COLOR
	$body.modulate = LIGHT_COLOR
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
