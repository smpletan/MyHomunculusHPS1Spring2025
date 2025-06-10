extends Node2D

var anim
var rng = RandomNumberGenerator.new()
var sewersVisit = ""
var sewersFullSuccess = false

func _ready():
	$OuterUI/ActivityContainer.visible = false
	Dialogic.signal_event.connect(_on_dialogic_signal)
	get_node("Background").get_node("%StartFadeAnimationPlayer").play("LightsOffFade_OUT")
	# get_node("Background").get_node("%BackGround").get_node("AnimatedSprite2D").play("LightsOffFade_OUT")

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
		$OuterUI/MoneyContainer/MoneyDisplay.text = str(int(Dialogic.VAR.cash))
	elif argument == "city_transition":
		get_node("Background").get_node("%EndSpriteFade").play("EndSpriteFade_IN")
		await get_tree().create_timer(0.4).timeout
		print("CITY")
		#TEMPORARY BACKGROUND till we can get a city
		get_node("Background").get_node("%Background_EndingSprite").play("Backgound_Playground")
		pass
	elif argument == "home_transition":
		pass
	elif argument == "gym_transition":
		get_node("Background").get_node("%EndSpriteFade").play("EndSpriteFade_IN")
		await get_tree().create_timer(0.4).timeout
		print("GYM")
		get_node("Background").get_node("%Background_EndingSprite").play("Background_Gym")
		#get_node("Background").get_node("%ForeGroundSpriteAnimated").visible = false
		#get_node("Background").get_node("%BackGroundReal").get_node("%BackGround").play("gym")
		pass
	elif argument == "fastfood_transition":
		get_node("Background").get_node("%EndSpriteFade").play("EndSpriteFade_IN")
		await get_tree().create_timer(0.4).timeout
		print("FASTFOOD")
		get_node("Background").get_node("%Background_EndingSprite").play("Background_Work")
		pass
	elif argument == "sewers_transition":
		get_node("Background").get_node("%EndSpriteFade").play("EndSpriteFade_IN")
		await get_tree().create_timer(0.4).timeout
		print("SEWER")
		get_node("Background").get_node("%Background_EndingSprite").play("Background_Sewer")
		pass
	elif argument == "lab_transition":
		get_node("Background").get_node("%EndSpriteFade").play("EndSpriteFade_OUT")
		#get_node("Background").get_node("%ForeGroundSpriteAnimated").visible = true
		#get_node("Background").get_node("%BackGroundReal").get_node("%BackGround").play("default")
		pass
	elif argument == "act_workout":
		$OuterUI/ActivityContainer.visible = true
		$OuterUI/ActivityContainer/ActivityPlayer/ActivityAnimation.play("WorkoutBench")
	elif argument == "act_running":
		$OuterUI/ActivityContainer.visible = true
		$OuterUI/ActivityContainer/ActivityPlayer/ActivityAnimation.play("RunningAround")
	elif argument == "act_playground":
		$OuterUI/ActivityContainer.visible = true
		$OuterUI/ActivityContainer/ActivityPlayer/ActivityAnimation.play("PlaygroundSwing")
	elif argument == "act_parttime":
		$OuterUI/ActivityContainer.visible = true
		$OuterUI/ActivityContainer/ActivityPlayer/ActivityAnimation.play("PartTimeJob")
	elif argument == "act_reading":
		$OuterUI/ActivityContainer.visible = true
		$OuterUI/ActivityContainer/ActivityPlayer/ActivityAnimation.play("Reading")
	elif argument == "act_watchcars":
		$OuterUI/ActivityContainer.visible = true
		$OuterUI/ActivityContainer/ActivityPlayer/ActivityAnimation.play("WatchingCars")
	elif argument == "act_sewers":
		$OuterUI/ActivityContainer.visible = true
		$OuterUI/ActivityContainer/ActivityPlayer/ActivityAnimation.play("Sewers")
	elif argument == "end_act":
		$OuterUI/ActivityContainer.visible = false
		#get_node("Background").get_node("%EndSpriteFade").play("EndSpriteFade_OUT")
	elif argument == "chance_sewers":
		var odds = ( (Dialogic.VAR.Stats.smarts / 100) * 20 + (Dialogic.VAR.Stats.strength / 100) * 20 + 
						(Dialogic.VAR.Stats.speed / 100) * 20 + (Dialogic.VAR.Stats.bravery / 100) * 20 + 20)
		var successcount = 0
		for n in 5:
			if( odds > rng.randi_range(0, 100) ) :
				successcount += 1
				print("Successes: " + str(successcount))
		if(successcount == 5) :
			if(!sewersFullSuccess) :
				sewersFullSuccess = true
				sewersVisit = ""
				Dialogic.VAR.cash += 50
			else :
				sewersVisit = "b"
		else :
			sewersVisit = ""
		Dialogic.VAR.Stats.strength += int(rng.randf_range(0, (randf_range(successcount, successcount * 1.5))))
		Dialogic.VAR.Stats.speed += int(rng.randf_range(0, (randf_range(successcount, successcount * 1.5))))
		Dialogic.VAR.Stats.bravery += int(rng.randf_range(0, (randf_range(successcount, successcount * 1.5))))
		Dialogic.VAR.cash += (successcount * 30) + int(10 * rng.randf_range(0, successcount * 1.2))
		Dialogic.start("sewerresult" + str(successcount) + sewersVisit)
