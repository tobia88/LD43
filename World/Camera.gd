extends Camera2D

var target : Node2D = null

func _physics_process(delta):
	if not target:
		return
		
	position.x = lerp(position.x, target.position.x, 0.1)
	position.y = lerp(position.y, target.position.y, 0.1)