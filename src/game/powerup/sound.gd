extends AudioStreamPlayer2D

export var parenthood := 0


func play(from := 0.0):
	if parenthood:
		var parent := get_parent()
		var i = 0
		while i != parenthood:
			parent = parent.get_parent()
			i+=1
		NodeUtils.reparent_keep_transform(self,parent)
	.play(from)
	yield(self,"finished")
	queue_free()
