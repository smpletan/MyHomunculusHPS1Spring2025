extends AnimationPlayer

func _on_animation_finished(_OpeningAnimation):
	print("Cutscene done")
	Dialogic.paused = false
