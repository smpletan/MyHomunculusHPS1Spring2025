extends CanvasLayer

var Pause_Menu : bool = true

func _ready() -> void:
	Pause_Menu == true
	pass

func _input(event):
	if Input.is_action_just_pressed("Pause"):
		if Pause_Menu == true:
			#visible = true
			#Pause_Menu = true
			#print("PAUSE ON")
			PauseOn()
			pass
		else:
			#visible = false
			#Pause_Menu = false
			#print("PAUSE OFF")
			PauseOff()
			pass


func PauseOn()-> void:
	$AnimationPlayer.play("Pause_ON")
	Pause_Menu = false
	print("PAUSE ON")
	pass
	
func PauseOff()-> void:
	$AnimationPlayer.play("Pause_OFF")
	Pause_Menu = true
	print("PAUSE OFF")
	pass
