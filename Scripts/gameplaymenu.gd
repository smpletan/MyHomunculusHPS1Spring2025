extends Node2D

var anim

func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	get_node("Background").get_node("%StartFadeAnimationPlayer").play("LightsOffFade_OUT")


func _on_dialogic_signal(argument:String):
	if argument == "begin_cutscene":
		Dialogic.paused = true
		get_node("Background").get_node("%OpeningAnimationPlayer").play("OpeningAnimation")
	elif argument == "update_stats":
		$OuterUI/StatMeterVBox/LoveMeter.value = Dialogic.VAR.Stats.love
		$OuterUI/StatMeterVBox/SmartsMeter.value = Dialogic.VAR.Stats.smarts
		$OuterUI/StatMeterVBox/StrengthMeter.value = Dialogic.VAR.Stats.strength
		$OuterUI/StatMeterVBox/SpeedMeter.value = Dialogic.VAR.Stats.speed
		$OuterUI/StatMeterVBox/BraveryMeter.value = Dialogic.VAR.Stats.bravery
		$OuterUI/StatMeterVBox/DiligenceMeter.value = Dialogic.VAR.Stats.diligence
		$OuterUI/StatMeterVBox/MediaLitMeter.value = Dialogic.VAR.Stats.medialit
		$OuterUI/StatMeterVBox/DrivingMeter.value = Dialogic.VAR.Stats.driving
