extends Node

var songs = {}

func _ready() -> void:
	for child in get_children():
		songs[child.name] = child

func play(song):
	for child in get_children():
		child.stop()
	songs[song].play()
