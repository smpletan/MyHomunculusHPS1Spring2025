extends Node2D

var anim
var rng = RandomNumberGenerator.new()
var sewersVisit = ""
var sewersFullSuccess = false
var ending_scene = ""
var holiday_days = [3, 7, 14, 19]
# Holidays List
#  0 : Big Game
#  1 : Evil Berry
#  2 : Hog Race
#  3 : Film Festival
#  4 : Spring Clean
var holiday_complete = [false, false, false, false, false]

func _ready():
	$OuterUI/ActivityContainer.visible = false
	Dialogic.signal_event.connect(_on_dialogic_signal)
	get_node("Background").get_node("%StartFadeAnimationPlayer").play("LightsOffFade_OUT")
	# get_node("Background").get_node("%BackGround").get_node("AnimatedSprite2D").play("LightsOffFade_OUT")

func resolve_growth():
	if (Dialogic.Var.Stats.driving >= 100) :
		# The Driver
		pass
	elif (Dialogic.VAR.Stats.love < 10 && Dialogic.VAR.Stats.smarts < 10 && Dialogic.VAR.Stats.strength < 10 \
		&& Dialogic.VAR.Stats.speed < 10 && Dialogic.VAR.Stats.bravery < 10 && Dialogic.VAR.Stats.diligence < 10 \
		&& Dialogic.VAR.Stats.diligence < 10 && Dialogic.VAR.Stats.medialit < 10 && Dialogic.VAR.Stats.driving < 10) :
		# Indifferent
		pass
	elif (Dialogic.VAR.Stats.love >= 80 && Dialogic.VAR.Stats.smarts >= 80 && Dialogic.VAR.Stats.strength >= 80 \
		&& Dialogic.VAR.Stats.speed >= 80 && Dialogic.VAR.Stats.bravery >= 80 && Dialogic.VAR.Stats.diligence >= 80 \
		&& Dialogic.VAR.Stats.diligence >= 80 && Dialogic.VAR.Stats.medialit >= 80 && Dialogic.VAR.Stats.driving >= 80) :
		# The Writer
		pass
	elif (Dialogic.VAR.Stats.love < 30 && Dialogic.VAR.Stats.smarts >= 80 && Dialogic.VAR.Stats.strength < 30 \
		&& Dialogic.VAR.Stats.speed < 30 && Dialogic.VAR.Stats.bravery < 30 && Dialogic.VAR.Stats.diligence < 30 \
		&& Dialogic.VAR.Stats.diligence < 30 && Dialogic.VAR.Stats.medialit < 30 && Dialogic.VAR.Stats.driving < 30) :
		# The Nerd
		pass
	elif (Dialogic.VAR.Stats.love < 20 && Dialogic.VAR.Stats.smarts < 20 && Dialogic.VAR.Stats.strength < 20 \
		&& Dialogic.VAR.Stats.speed < 20 && Dialogic.VAR.Stats.bravery >= 80 && Dialogic.VAR.Stats.diligence < 20 \
		&& Dialogic.VAR.Stats.diligence < 20 && Dialogic.VAR.Stats.medialit < 20 && Dialogic.VAR.Stats.driving < 20) :
		# Hot Dogged
		pass
	elif (Dialogic.VAR.Stats.love >= 50 && Dialogic.VAR.Stats.smarts >= 50 && Dialogic.VAR.Stats.strength >= 50 \
		&& Dialogic.VAR.Stats.speed >= 50 && Dialogic.VAR.Stats.bravery >= 50 && Dialogic.VAR.Stats.diligence >= 50 \
		&& Dialogic.VAR.Stats.diligence >= 50) :
		# Middle of the Road
		pass
	elif (Dialogic.VAR.Stats.diligence >= 90) && (Dialogic.VAR.Stats.smarts >= 90) && (Dialogic.VAR.Stats.evil >= 50) :
		# The Wizard
		pass
	elif (Dialogic.VAR.Stats.diligence >= 80) && (Dialogic.VAR.Stats.smarts >= 60) && (Dialogic.VAR.Stats.evil <= 30) :
		# CEO Normal
		pass
	elif (Dialogic.VAR.Stats.diligence >= 80) && (Dialogic.VAR.Stats.smarts >= 60) && (Dialogic.VAR.Stats.evil > 30) :
		# CEO Evil
		pass
	elif (Dialogic.VAR.Stats.strength >= 70) && (Dialogic.VAR.Stats.speed >= 70) && (Dialogic.VAR.Stats.love >= 50) :
		# Gym Bro
		pass
	elif (Dialogic.VAR.Stats.love >= 80) && (Dialogic.VAR.Stats.strength <= 30) && (Dialogic.VAR.Stats.diligence >= 40):
		# Best in Show
		pass
	elif (Dialogic.VAR.Stats.love >= 80) && (Dialogic.VAR.Stats.medialit >= 50) && (Dialogic.VAR.Stats.smarts <= 50):
		# Love to See It
		pass
	elif (Dialogic.VAR.Stats.bravery >= 80) && (Dialogic.VAR.Stats.love >= 80) && (Dialogic.VAR.Stats.driving >= 40):
		# The Sully Ending
		pass
	elif (Dialogic.VAR.Stats.love >= 80) && (Dialogic.VAR.Stats.medialit >= 50) && (Dialogic.VAR.Stats.smarts <= 50):
		# The Foolhardy Butler Sir
		pass
	elif (Dialogic.VAR.Stats.strength >= 80) && (Dialogic.VAR.Stats.love >= 80) :
		# The Thing (of the Lake)
		pass
	elif (Dialogic.VAR.Stats.speed >= 80) && (Dialogic.VAR.Stats.driving >= 50) :
		# The Car
		pass
	elif (Dialogic.VAR.Stats.speed >= 80) :
		# The Horse
		pass
	elif (Dialogic.VAR.Stats.love <= 15) && (Dialogic.VAR.Stats.evil >= 40) :
		# Neglected
		pass
	elif (Dialogic.VAR.Stats.love >= 110) :
		# My Animal
		pass
	
func check_in_range(stat: float, target: float, low_range: int, high_range: int):
	return (stat >= target - low_range && stat <= target + high_range)

func _on_dialogic_signal(argument:String):
	if argument == "begin_cutscene":
		Dialogic.paused = true
		get_node("Background").get_node("%OpeningAnimationPlayer").play("OpeningAnimation")
	elif argument == "roll_holiday":
		while Dialogic.VAR.next_holiday.is_empty() :
			var roll = randi_range(0, 4)
			if holiday_complete[roll] == false :
				match roll:
					0:
						Dialogic.VAR.next_holiday = "biggame"
						holiday_complete[0] = true
					1:
						Dialogic.VAR.next_holiday = "evilberry"
						holiday_complete[1] = true
					2:
						Dialogic.VAR.next_holiday = "hograce"
						holiday_complete[2] = true
					3:
						Dialogic.VAR.next_holiday = "filmfest"
						holiday_complete[3] = true
					4:
						Dialogic.VAR.next_holiday = "springcleaning"
						holiday_complete[4] = true
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
		get_node("Background").get_node("%Background_EndingSprite").play("Background_City")
		pass
	elif argument == "cars_transition":
		get_node("Background").get_node("%EndSpriteFade").play("EndSpriteFade_IN")
		await get_tree().create_timer(0.4).timeout
		get_node("Background").get_node("%Background_EndingSprite").play("Background_Cars")
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
	elif argument == "hotdogs_transition":
		get_node("Background").get_node("%EndSpriteFade").play("EndSpriteFade_IN")
		await get_tree().create_timer(0.4).timeout
		get_node("Background").get_node("%Background_EndingSprite").play("Background_HotDogs")
		pass
	elif argument == "hograce_transition":
		get_node("Background").get_node("%EndSpriteFade").play("EndSpriteFade_IN")
		await get_tree().create_timer(0.4).timeout
		get_node("Background").get_node("%Background_EndingSprite").play("Background_HogRace")
		pass
	elif argument == "evilberry_transition":
		get_node("Background").get_node("%EndSpriteFade").play("EndSpriteFade_IN")
		await get_tree().create_timer(0.4).timeout
		get_node("Background").get_node("%Background_EndingSprite").play("Background_EvilBerry")
		pass
	elif argument == "act_workout":
		$OuterUI/ActivityContainer.visible = true
		$OuterUI/ActivityContainer/ActivityPlayer/ActivityAnimation.play("WorkoutBench")
	elif argument == "act_running":
		$OuterUI/ActivityContainer.visible = true
		$OuterUI/ActivityContainer/ActivityPlayer/ActivityAnimation.play("RunningAround")
	elif argument == "act_beatup":
		$OuterUI/ActivityContainer.visible = true
		$OuterUI/ActivityContainer/ActivityPlayer/ActivityAnimation.play("BeatUp")
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
		Dialogic.VAR.Stats.strength += int(rng.randi_range(-1, 1))
		Dialogic.VAR.Stats.speed += int(rng.randi_range(-1, 1))
		Dialogic.VAR.Stats.speed += int(rng.randi_range(-1, 1))
		Dialogic.VAR.Stats.bravery += int(rng.randi_range(-1, 1))
		Dialogic.VAR.Stats.medialit += int(rng.randi_range(-1, 3))
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
	elif argument == "chance_hotdog":
		var odds = (Dialogic.VAR.Stats.bravery / 100) * 70 + 30
		for n in 2:
			if( odds > rng.randi_range(0, 100) ) :
				Dialogic.VAR.Stats.hotdog_success += 1
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
