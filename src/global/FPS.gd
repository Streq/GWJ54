extends Node


export var force_fps := 0


func _ready() -> void:
	if force_fps>0:
		Engine.target_fps = force_fps
