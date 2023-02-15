extends Area2D

export var damage := 20.0
export var knockback := 150.0
export var vertical_knockback := -25.0
var team setget, get_team
var vertical_position setget, get_vertical_position
signal hit_landed(on)



func _ready() -> void:
	connect("area_entered",self,"_on_area_entered")
	deactivate()
	
func _on_area_entered(area : Area2D):
	if area.owner == owner or area.team == get_team() or abs(get_vertical_position()-area.vertical_position)>5.0:
		return
	
	emit_signal("hit_landed",area)
	area.receive_damage(damage)
	area.receive_knockback(Vector2.RIGHT.rotated(global_rotation), knockback, vertical_knockback)
	

func activate():
	monitoring = true

func deactivate():
	monitoring = false

func get_team():
	return owner.team
	
func get_vertical_position():
	return get_parent().vertical_position
