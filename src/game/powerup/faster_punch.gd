extends Node


func trigger(limb):
	limb.speed_factor *= 2.0
	limb.finish_lag_factor /= 2.0
	limb.start_lag_factor /= 2.0
	limb.scale *= 0.75
	limb.damage_factor *= 0.9
