extends Sprite
onready var animation_player: AnimationPlayer = $AnimationPlayer

func trigger():
	animation_player.play("play")
	
#	create_tween().tween_property(self,"scale",)
	
#	animation_player.current_animation_length
