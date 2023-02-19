extends Node
signal enemies_appeared
signal enemies_cleared

var enemies = {}

func _ready() -> void:
	for enemy in Group.get_all("enemy"):
		add_enemy(enemy)
	
	get_tree().connect("node_added",self,"node_entered")
	
func node_entered(node:Node):
	if node.is_in_group("enemy"):
		add_enemy(node)

func add_enemy(enemy:Node):
	if !enemies:
		emit_signal("enemies_appeared")
	enemies[enemy] = null
	enemy.connect("tree_exiting",self,"remove_enemy",[enemy])

func remove_enemy(enemy:Node):
	if !enemies.has(enemy):
		return
	enemies.erase(enemy)
	if !enemies:
		emit_signal("enemies_cleared")

func clear():
	var aux = enemies
	enemies = {}
	for key in aux.keys():
		key.queue_free()
	queue_free()
