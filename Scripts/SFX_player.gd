extends AudioStreamPlayer

#@onready var dummy_player = AudioStreamPlayer.new()

#var fading = false

#func _ready() -> void:
	#add_child(dummy_player)
	#dummy_player.bus = &"SFX"
	#bus = &"SoundEffects"
	#print(AudioServer.get_bus_effect(bus, effect).get_class())
	#pass
	#stream = load("res://Assets/Audio/Silence.mp3")
	#play()

#func _process(delta: float) -> void:
	#if fading:
		#volume_db -= 40*delta
		#dummy_player.volume_db += 40*delta
		
		#if dummy_player.volume_db >= -2:
			#volume_db = -2
			#dummy_player.volume_db = -80
			
		#	stream = dummy_player.stream
			#play(dummy_player.get_playback_position())
			
			#dummy_player.stop()
			#fading = false

#func Volume(db) -> void:
#	volume_db = db

func play_sfx(song_name, db) -> void:
	#volume_db = -6
	volume_db = db
	bus = &"SoundEffects"
	stream = load("res://Assets/Audio/SFX/" + song_name + ".mp3")
	play()
	#dummy_player.stream = load("res://Assets/Audio/SFX/" + song_name + ".mp3")
	#dummy_player.volume_db = -80
	#dummy_player.play()
	
	#fading = true
	
	
	#example code to call with "this" being the filename
	#SfxPlayer.play_sfx("Silence", -8)


func _on_finished() -> void:
	volume_db = -4
	stop()
