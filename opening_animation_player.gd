extends AnimationPlayer

func _on_animation_finished(_OpeningAnimation):
	print("Cutscene done")
	Dialogic.paused = false
	#get_parent().get_node("Menu").get_node("MainMusicPlayer").set_playing(true)
	#MusicPlayer.play_music_menu()
	#MusicPlayer.play_song("HomuncGameplayMain1")
	pass

func _on_start_music_node_property_list_changed() -> void:
	MusicPlayer.play_song("HomuncGameplayMain1")
	pass 

func _on_start_sfx_node_property_list_changed() -> void:
	SfxPlayer.play_sfx("HomuncOpening", -12)
	pass
