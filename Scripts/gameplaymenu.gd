extends Node2D

var anim
var rng = RandomNumberGenerator.new()
var sewersVisit = ""
var sewersFullSuccess = false
var ending_scene = ""
# God I really wasn't hoping to do it like this, but it's a solid fallback for a growth points system.
#  Index : Ending
#  0 : Indifferent (All stats below 10)
#  1 : Horse (Speed highest at above 80, no other stat high enough)
#  2 : Neglected (Love below 15, Evil above 40-50)
#  3 : CEO Mindset Neutral (Diligence above 80, Smarts above 60, Evil below 30)
#  4 : CEO Mindset Evil (Diligence above 80, Smarts above 60, Evil above 30)
#  5 : Gym Bro (Strength + Speed above 70-80, Love above 50)
#  6 : Firefighter (Bravery above 80, Strength above 60, Speed above 60)
#  7 : Film Buff (Smarts above 60, Below 10 Media Literacy)
#  8 : NL (Smarts above 60, Above 50 Media Literacy)
#  9 : Car (Speed above 80, Driving above 50)
# 10 : Driver (Driving at 100. Overrides any other ending.)
# 11 : Butler (Diligence above 80, Love above 60, Smarts below 60, Bravery below 50)
var growth_array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

func _ready():
	$OuterUI/ActivityContainer.visible = false
	Dialogic.signal_event.connect(_on_dialogic_signal)
	get_node("Background").get_node("%StartFadeAnimationPlayer").play("LightsOffFade_OUT")
	# get_node("Background").get_node("%BackGround").get_node("AnimatedSprite2D").play("LightsOffFade_OUT")

func resolve_growth():
	growth_array[0] = (Dialogic.VAR.Stats.love < 10 && Dialogic.VAR.Stats.smarts < 10 && Dialogic.VAR.Stats.strength < 10 \
		&& Dialogic.VAR.Stats.speed < 10 && Dialogic.VAR.Stats.bravery < 10 && Dialogic.VAR.Stats.diligence < 10 \
		&& Dialogic.VAR.Stats.diligence < 10 && Dialogic.VAR.Stats.medialit < 10 && Dialogic.VAR.Stats.driving < 10)
	growth_array[1] = (Dialogic.VAR.Stats.speed >= 80)
	growth_array[2] = (Dialogic.VAR.Stats.love <= 15) + (Dialogic.VAR.Stats.evil >= 40)
	growth_array[3] = (Dialogic.VAR.Stats.diligence >= 80) + (Dialogic.VAR.Stats.smarts >= 60) + (Dialogic.VAR.Stats.evil <= 30)
	growth_array[4] = (Dialogic.VAR.Stats.diligence >= 80) + (Dialogic.VAR.Stats.smarts >= 60) + (Dialogic.VAR.Stats.evil > 30)
	growth_array[5] = (Dialogic.VAR.Stats.strength >= 70) + (Dialogic.VAR.Stats.speed >= 70) + (Dialogic.VAR.Stats.love >= 50)
	growth_array[6] = (Dialogic.VAR.Stats.bravery >= 60) + (Dialogic.VAR.Stats.strength >= 60) + (Dialogic.VAR.Stats.diligence >= 60)
	
	growth_array[10] = (Dialogic.VAR.Stats.driving >= 100)
	print("Yes")
	
func check_in_range(stat: float, target: float, low_range: int, high_range: int):
	return (stat >= target - low_range && stat <= target + high_range)

func _on_dialogic_signal(argument:String):
	if argument == "begin_cutscene":
		Dialogic.paused = true
		get_node("Background").get_node("%OpeningAnimationPlayer").play("OpeningAnimation")
	elif argument == "update_stats":
		#Force a lower clamp to the Love stat.
		if(Dialogic.VAR.Stats.love < -20):
			Dialogic.VAR.Stats.love = -20
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
		get_node("Background").get_node("%Background_EndingSprite").play("Background_Playground")
		pass
	elif argument == "playground_transition":
		get_node("Background").get_node("%EndSpriteFade").play("EndSpriteFade_IN")
		await get_tree().create_timer(0.4).timeout
		#TEMPORARY BACKGROUND till we can get a city
		get_node("Background").get_node("%Background_EndingSprite").play("Background_Playground")
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
		get_node("Background").get_node("%Background_EndingSprite").play("Background_Sewer")
		pass
	elif argument == "tv_transition":
		get_node("Background").get_node("%EndSpriteFade").play("EndSpriteFade_IN")
		await get_tree().create_timer(0.4).timeout
		get_node("Background").get_node("%Background_EndingSprite").play("Background_TV")
		pass
	elif argument == "kitchen_transition":
		get_node("Background").get_node("%EndSpriteFade").play("EndSpriteFade_IN")
		await get_tree().create_timer(0.4).timeout
		get_node("Background").get_node("%Background_EndingSprite").play("Background_Kitchen")
		pass
	elif argument == "ipad_transition":
		get_node("Background").get_node("%EndSpriteFade").play("EndSpriteFade_IN")
		await get_tree().create_timer(0.4).timeout
		get_node("Background").get_node("%Background_EndingSprite").play("Background_IPAD_animation")
		pass
	elif argument == "pc_transition":
		get_node("Background").get_node("%EndSpriteFade").play("EndSpriteFade_IN")
		await get_tree().create_timer(0.4).timeout
		get_node("Background").get_node("%Background_EndingSprite").play("Background_PC")
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
	elif argument == "act_tv":
		$OuterUI/ActivityContainer.visible = true
		$OuterUI/ActivityContainer/ActivityPlayer/ActivityAnimation.play("WatchTV")
	elif argument == "act_ipad":
		pass
	elif argument == "act_pc":
		$OuterUI/ActivityContainer.visible = true
		$OuterUI/ActivityContainer/ActivityPlayer/ActivityAnimation.play("Computer")
	elif argument == "act_beatup":
		$OuterUI/ActivityContainer.visible = true
		$OuterUI/ActivityContainer/ActivityPlayer/ActivityAnimation.play("BeatUp")
	elif argument == "act_dinner":
		$OuterUI/ActivityContainer.visible = true
		$OuterUI/ActivityContainer/ActivityPlayer/ActivityAnimation.play("Cooking")
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
		elif(successcount == 4) :
			if(!sewersFullSuccess) :
				sewersFullSuccess = true
				sewersVisit = ""
			else :
				sewersVisit = "a"
		elif(successcount == 3) :
			if(!sewersFullSuccess) :
				sewersFullSuccess = true
				sewersVisit = ""
			else :
				sewersVisit = "a"
		else :
			sewersVisit = ""
		Dialogic.VAR.Stats.strength += int(rng.randf_range(0, (randf_range(successcount, successcount * 1.5))))
		Dialogic.VAR.Stats.speed += int(rng.randf_range(0, (randf_range(successcount, successcount * 1.5))))
		Dialogic.VAR.Stats.bravery += int(rng.randf_range(0, (randf_range(successcount, successcount * 1.5))))
		Dialogic.VAR.cash += (successcount * 30) + int(10 * rng.randf_range(0, successcount * 1.2))
		Dialogic.start("sewerresult" + str(successcount) + sewersVisit)
