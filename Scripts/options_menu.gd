extends CanvasLayer


var Pause_Menu : bool = true

func _ready() -> void:
	Pause_Menu == true
	pass

func _input(event):
	if Input.is_action_just_pressed("Pause"):
		if Pause_Menu == true:
			PauseOn()
			#get_node("Background").get_node("%OpeningStreamPlayer").stop(music_position)
			pass
		else:
			PauseOff()
			#music_position = get_node("Background").get_node("%OpeningStreamPlayer").get_playback_position()
			pass


func PauseOn()-> void:
	$AnimationPlayer.play("Pause_ON")
	Engine.time_scale = 0
	SfxPlayer.set_stream_paused(true)
	AudioServer.set_bus_effect_enabled(2, 0, true)
	#get_node("Background").get_node("%OpeningStreamPlayer").stop(music_position)
	Pause_Menu = false
	$ResumeButton2.call_deferred("grab_focus")
	print("PAUSE ON")
	pass
	
func PauseOff()-> void:
	$AnimationPlayer.play("Pause_OFF")
	AudioServer.set_bus_effect_enabled(2, 0, false)
	#get_node("VBoxContainer").get_node("%StartButton").call_deferred("grab_focus")
#	get_node("/root/VBoxContainer/StartButton").call_deferred("grab_focus")
	Engine.time_scale = 1
	SfxPlayer.set_stream_paused(false)
	#music_position = get_node("Background").get_node("%OpeningStreamPlayer").get_playback_position()
	Pause_Menu = true
	print("PAUSE OFF")
	pass


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_resume_button_pressed() -> void:
	PauseOff()


func _on_options_button_pressed() -> void:
	PauseOn()

#func _on_option_button_item_selected(index: int) -> void:
	#match index:
		#0: print("Fullscreen")
		#	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		#1: print("Windowed")


func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_quit_button_2_pressed() -> void:
	get_tree().quit()

func _on_resume_button_2_pressed() -> void:
	PauseOff()
