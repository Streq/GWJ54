extends Node2D

onready var glove: Node2D = $glove

export var trigger_action := "A"



func _physics_process(delta: float) -> void:
	if !owner.locked_in:
		look_at(get_global_mouse_position())
	if !Engine.editor_hint and Input.is_action_pressed(trigger_action):
		glove.punch()
