extends Node


func trigger(limb):
	limb.speed_factor *= 2.0
	limb.finish_lag_factor /= 1.5
	limb.start_lag_factor /= 1.5
	limb.scale *= 0.75
	limb.damage_factor *= 0.9
