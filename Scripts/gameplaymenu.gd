extends Node2D

var anim

func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.start("newgame")

func _on_dialogic_signal(argument:String):
	if argument == "begin_cutscene":
		Dialogic.paused = true
		get_node("Background").get_node("%OpeningAnimationPlayer").play("OpeningAnimation")
