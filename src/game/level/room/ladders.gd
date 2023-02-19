extends Node2D

signal next_level



func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		emit_signal("next_level")
