extends Node


func trigger(limb):
	limb.scale *= 1.5
	limb.start_lag_factor *= 3.0
	limb.finish_lag_factor *= 3.0
	limb.damage_factor *= 2.0
	limb.reach_factor /= 1.5
	limb.speed_factor *= 0.5
	limb.knockback_factor *= 1.5
