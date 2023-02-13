extends Area2D

export var damage := 20.0
export var knockback := 100.0
var team setget, get_team
signal hit_landed(on)



func _ready() -> void:
	connect("area_entered",self,"_on_area_entered")
	deactivate()
	
func _on_area_entered(area : Area2D):
	if area.owner == owner or area.team == get_team():
		return
	
	emit_signal("hit_landed",area)
	area.receive_damage(damage)
	area.receive_knockback(Vector2.RIGHT.rotated(global_rotation),knockback)
	

func activate():
	monitoring = true

func deactivate():
	monitoring = false

func get_team():
	return owner.team
	
