class_name NodeUtils


static func reparent(node: Node, to: Node)->void:
	node.get_parent().remove_child(node)
	to.add_child(node)

static func add_or_reparent(node: Node, to: Node):
	if node.get_parent() == to:
		return
	if node.get_parent():
		node.get_parent().remove_child(node)
	to.add_child(node)

static func reparent_keep_transform(node: Node2D, to: Node2D)->void:
	var aux_t = node.global_transform
	reparent(node,to)
	node.global_transform = aux_t


static func pause(node: Node, val: bool)->void:
	node.set_process(val)
	node.set_process_input(val)
	node.set_process_internal(val)
	node.set_process_unhandled_input(val)
	node.set_process_unhandled_key_input(val)
	node.set_physics_process(val)
	node.set_physics_process_internal(val)
