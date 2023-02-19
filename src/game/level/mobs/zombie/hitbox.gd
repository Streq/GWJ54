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

export var disabled = true
export var clashable := true


func _ready() -> void:
	connect("area_entered",self,"_on_area_entered")
	if !clashable:
		collision_layer = 0
	if disabled:
		deactivate()
	else:
		activate()

func _on_area_entered(area : Area2D):
	if (disabled or 
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
		emit_signal("clash_lost")
		

func clash_lost():
	emit_signal("clash")

func abort():
	if disabled:
		return
	disabled = true
	emit_signal("abort")


func affect_hurtbox(hurtbox):
	emit_signal("hit_landed",hurtbox)
	hurtbox.receive_damage(damage)
	hurtbox.receive_knockback(Vector2.RIGHT.rotated(global_rotation), knockback, vertical_knockback)


func activate():
	monitoring = true
	monitorable = true
	disabled = false
	exceptions = []

func deactivate():
	monitoring = false
	monitorable = false
	disabled = true

func get_team():
	return owner.team
	
func get_vertical_position():
	return owner.vertical_position
