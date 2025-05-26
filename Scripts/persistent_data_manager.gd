extends Node

const SAVE_PATH = "user://"

signal game_loaded
signal game_saved

var current_save : Dictionary = {
	scene_path = "",
	homunculus = {
		love = 0,
		smarts = 0,
		driving = 0,
		strength = 0,
		speed = 0,
		medialit = 0,
		bravery = 0,
		evil = 0
	},
	date = 0,
	choices = [
		
	],
	cash = 0
}
