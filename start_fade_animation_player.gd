extends AnimationPlayer



func _on_animation_finished(_LightsOffFade_OUT):
	print("Cutscene done")


#func _on_fade_background_opening_hidden() -> void:
		#Dialogic.start("newgame")




func _on_node_property_list_changed() -> void:
	Dialogic.start("newgame")
