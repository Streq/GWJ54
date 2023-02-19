extends CanvasLayer

onready var label: Label = $"%label"

onready var dude: KinematicBody2D = $"%dude"
onready var wizard: KinematicBody2D = $"%wizard"

signal user_pressed_space



func say(text):
	label.text = text
func _ready() -> void:
	dude.hide()
	wizard.hide()
	
	say("In the small town of Baron Park, there is a tiny but important boxing community that holds an annual tournament.")
	yield(self,"user_pressed_space")
	say("Bobby here, our hero, has been trying to win every year, and every year he has lost.")
	dude.show()
	yield(self,"user_pressed_space")
	say("Last year he came up second, losing to some guy. That was the closest he ever got to winning the championship.")
	yield(self,"user_pressed_space")
	say("Ever since that, Bobby has been training all day, every day, for this year's tournament. He's decided he's gonna win no matter what.")
	yield(self,"user_pressed_space")
	dude.hide()
	say("But life doesn't really work that way.")
	yield(self,"user_pressed_space")
	say("This year, a new challenger got into the tournament")
	wizard.show()
	yield(self,"user_pressed_space")
	say("An evil wizard who had just went through a rough divorce")
	yield(self,"user_pressed_space")
	say("And who decided to enter the tournament because he's going through a macho phase")
	yield(self,"user_pressed_space")
	say("The thing is, this guy doesn't play fair.")
	yield(self,"user_pressed_space")
	say("Long story short, he curses his opponents into endless nightmares were they never get out, let alone up to beat the count.")
	yield(self,"user_pressed_space")
	say("They just fall to the ground, limp. Not a punch thrown, or received.")
	yield(self,"user_pressed_space")
	say("He made it to the finals this way.")
	yield(self,"user_pressed_space")
	say("He's now up against Bobby.")
	dude.show()
	dude.position.x = 32.0
	wizard.position.x = -32.0
	yield(self,"user_pressed_space")
	say("As soon as the fight begun, he managed to lull Bobby to sleep like it was nothing.")
	yield(self,"user_pressed_space")
	say("But Bobby's determination is stronger than any curse, or at least we all hope that is the case.")
	wizard.hide()
	dude.position.x = 0.0
	yield(self,"user_pressed_space")
	say("Can Bobby escape this nightmarish world, beat the count, and kick that bastard's ass??")
	yield(self,"user_pressed_space")
	
	get_tree().change_scene("res://src/test/world_test/World.tscn")
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("C"):
		emit_signal("user_pressed_space")
