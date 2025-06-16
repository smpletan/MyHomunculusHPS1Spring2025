extends Control

func _ready():
	$VBoxContainer/StartButton.grab_focus()

func _on_start_button_pressed():
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://gameplay.tscn")
	#get_node("FadeSceneCanvasLayer").get_node("AnimationPlayer").play("Fade_IN")
	#$FadeTimer.start()

	
func _on_quit_button_pressed():
	get_tree().quit()

#@onready var fade_timer: Timer = $FadeSceneCanvasLayer/FadeTimer


#func _on_fade_timer_timeout() -> void:
	#get_tree().change_scene_to_file("res://gameplay.tscn")
