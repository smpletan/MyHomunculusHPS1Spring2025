extends AnimationPlayer

func _on_animation_finished(_OpeningAnimation):
	print("Cutscene done")
	Dialogic.paused = false
	#get_parent().get_node("Menu").get_node("MainMusicPlayer").set_playing(true)
	pass
