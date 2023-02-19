extends StaticBody2D
signal player_exiting_through

onready var collision_shape: CollisionShape2D = $collision_shape
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var player_spawn: Position2D = $player_spawn

var open := false


func close():
	open = false
	animation_player.play("close")
	animation_player.queue("closed")
func open():
	open = true
	animation_player.play("open")
	animation_player.queue("opened")

func opened():
	open = true
	animation_player.play("opened")


func _on_change_room_area_body_entered(body: Node) -> void:
	if !open:
		return
	if body.is_in_group("player"):
		emit_signal("player_exiting_through")
