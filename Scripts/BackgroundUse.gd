extends AnimatedSprite2D

#func _process(delta: float) -> void:
	#position.x += (get_viewport().get_mouse_position().x/-1.5*delta)-position.x
