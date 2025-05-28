extends CanvasLayer

signal on_transition_finished

@onready var sprite = $AnimationPlayer/AnimatedSprite2D
@onready var animation_player = $AnimationPlayer

func _ready():
	sprite.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)
	
func _on_animation_finished(anim_name):
		if anim_name == "Fade_IN":
			animation_player.play("Fade_OUT")
			on_transition_finished.emit()
		elif anim_name == "Fade_OUT":
			sprite.visible = false

func transition():
	sprite.visible = true
	animation_player.play("Fade_IN")
