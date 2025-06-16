extends AudioStreamPlayer

@onready var dummy_player = AudioStreamPlayer.new()

var fading = false

func _ready() -> void:
	add_child(dummy_player)
	dummy_player.bus = &"Music"
	bus = &"Music"
		
	stream = load("res://Assets/Audio/HomuncMenu1.mp3")
	play()

func _process(delta: float) -> void:
	if fading:
		volume_db -= 30*delta
		dummy_player.volume_db += 30*delta
		
		if dummy_player.volume_db >= -18:
			volume_db = -18
			dummy_player.volume_db = -80
			
			stream = dummy_player.stream
			play(dummy_player.get_playback_position())
			
			dummy_player.stop()
			fading = false


func play_song(song_name) -> void:
	dummy_player.stream = load("res://Assets/Audio/" + song_name + ".mp3")
	dummy_player.volume_db = -80
	dummy_player.play()
	
	fading = true
