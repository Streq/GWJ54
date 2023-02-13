extends Weapon

signal punching_motion_started
signal punching_motion_ended
signal extended


export var reach := 100
export var start_pull_back := 10
export var start_lag_time := 0.1
export var extend_time := 0.25
export var extend_scale := 2.0
export var retrieve_lag_time := 0.1
export var retrieve_time := 0.25
export var cooldown := 0.15
var left_hand := false

var team setget,get_team

func get_team():
	if is_instance_valid(wielder):
		return wielder.team
	return null
onready var animation_player: AnimationPlayer = $AnimationPlayer


var busy = false
var tween : SceneTreeTween = null
var start_position := Vector2()
var start_rotation := 0.0
var in_attack_motion = false

var wielder = false

onready var pivot = get_parent()

func _physics_process(delta: float) -> void:
	if !tween or !tween.is_valid() and pivot.is_a_parent_of(self):
		transform = Transform2D.IDENTITY

func _cast():
	punch()


func punch():
	busy = true
	
	if tween:
		tween.kill()
	tween = create_tween()
	
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	
	tween.tween_callback(animation_player,"play",["punch"])
	
	NodeUtils.reparent_keep_transform(self, pivot)
	#lag
#	tween.tween_property(self,"position",Vector2(-10,0),start_lag_time).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
	tween.tween_property(self,"transform",Transform2D(0,Vector2(-start_pull_back,0)),start_lag_time).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
	
	#punch
	tween.tween_callback(self,"punch_motion_begin")
	tween.tween_property(self,"position",Vector2(reach,0),extend_time).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUART)
	tween.parallel().tween_property(self,"scale",Vector2(extend_scale,extend_scale),extend_time).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUART)
	tween.tween_callback(self,"extended")
	if retrieve_lag_time:
		tween.tween_interval(retrieve_lag_time)
	tween.tween_callback(self,"retrieving")
	tween.tween_method(self,"lerp_to_pivot_from_start_position",0.0,1.0,retrieve_time).set_trans(Tween.TRANS_LINEAR)
	tween.parallel().tween_property(self,"scale",pivot.scale,retrieve_time)
	tween.parallel().tween_callback(self,"can_punch_again").set_delay(cooldown)
	tween.tween_callback(animation_player,"play",["punch"])
	tween.tween_callback(self,"punch_over")

func extended():
	emit_signal("extended")
	NodeUtils.reparent_keep_transform(self, pivot.owner.get_parent())
#	pivot.owner.punching = false
#	pivot.owner.locked_in = false
	
	unlock_aim()
	emit_signal("punching_motion_ended")
	
func punch_motion_begin():
	lock_aim()
	emit_signal("punching_motion_started")

func retrieving():
	start_position = global_position
	start_rotation = global_rotation
	

func can_punch_again():
	busy = false
	cast_over()
	


func punch_over():
	can_punch_again()
	
	NodeUtils.reparent_keep_transform(self, pivot)
	transform = Transform2D.IDENTITY
	if tween:
		tween.kill()
	
	animation_player.play("idle")
	
	in_attack_motion = false


var prev_dist = 0


var weight 
func lerp_to_pivot_from_start_position(weight):
	
	global_position = start_position.linear_interpolate(pivot.global_position,weight)
	var current_dist = global_position.distance_squared_to(pivot.global_position)
	var initial_dist = start_position.distance_squared_to(pivot.global_position)
	if current_dist<initial_dist:
#		start_position = global_position
#		weight *= sqrt(initial_dist/current_dist)
		pass
	global_rotation = lerp_angle(start_rotation,pivot.global_rotation,weight)
	
#	look_at(pivot.global_position)
	
	var dist = global_position.distance_squared_to(pivot.global_position)
	print(prev_dist<dist)
	prev_dist = dist
	if global_position.distance_squared_to(pivot.global_position) < 5*5:
		punch_over()

func _init() -> void:
	connect("tree_entered",self,"_on_tree_entered")

func _on_tree_entered() -> void:
	if get_parent() and get_parent().is_in_group("hand") and get_parent().weapon != self:
		get_parent().add_weapon(self)
