class_name PersistentDataManager extends Node

signal data_loaded
var value : bool = false

func _ready() -> void:
	print(_get_name())
	pass
	
func set_value () -> void:
	pass
	
func get_value () -> void:
	pass
	
func _get_name () -> String:
	return get_tree().current_scene.scene_file_path + "/" + get_parent().name + "/" + name
