extends AnimatedSprite2D

#func _process(delta: float) -> void:
	#position += (get_viewport().get_mouse_position()/-1.5*delta)-position
