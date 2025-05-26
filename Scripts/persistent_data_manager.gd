extends Node

const SAVE_PATH = "user://"

signal game_loaded
signal game_saved

var current_save : Dictionary = {
	scene_path = "",
	homunculus = {
		# Stats for the homunculus. We structure them from 0 to 1.
		love = 0,
		smarts = 0,
		driving = 0,
		strength = 0,
		speed = 0,
		medialit = 0,
		bravery = 0,
		evil = 0
	},
	# The current date of the 1-30 day calendar.
	date = 0,
	# An array containing important plot-relevant choices
	choices = [
		
	],
	cash = 0
}
