extends AudioStreamPlayer2D


func play(from:=0.0):
	pitch_scale = owner.limb.speed_factor
	.play(from)
	pass
