extends Area2D
signal abort
signal clash

signal hit_landed(on)

export var damage := 20.0
export var knockback := 150.0
export var vertical_knockback := -25.0

var exceptions = []

var team setget, get_team
var vertical_position setget, get_vertical_position


var aborted = true

func _ready() -> void:
	connect("area_entered",self,"_on_area_entered")
	deactivate()
func _on_area_entered(area : Area2D):
	if (aborted or 
		area.owner == owner or 
		area.team == get_team() or 
		abs(get_vertical_position()-area.vertical_position)>5.0 or
		exceptions.find(area) != -1
	):
		return
	area.handle_hitbox(self)
	exceptions.append(area)

func handle_hitbox(hitbox):
	if hitbox.damage - damage < 5.0:
		hitbox.abort()
		
	
func abort():
	if aborted:
		return
	aborted = true
	emit_signal("abort")
	emit_signal("clash")


func affect_hurtbox(hurtbox):
	emit_signal("hit_landed",hurtbox)
	hurtbox.receive_damage(damage)
	hurtbox.receive_knockback(Vector2.RIGHT.rotated(global_rotation), knockback, vertical_knockback)


func activate():
	monitoring = true
	monitorable = true
	aborted = false
	exceptions = []

func deactivate():
	monitoring = false
	monitorable = false
	aborted = true

func get_team():
	return owner.team
	
func get_vertical_position():
	return get_parent().vertical_position
