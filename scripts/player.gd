# player.gd
extends KinematicBody2D

# unsere Variablen - Variablen werden gewöhnlich klein geschrieben
var velocity = Vector2() # velocity heißt Geschwindigkeit

# unsere erste Funktion
func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = 30
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -30
	else:
		velocity.x = 0

	if Input.is_action_pressed("ui_up"):
		velocity.y = -30
	elif Input.is_action_pressed("ui_down"):
		velocity.y = 30
	else:
		velocity.y = 0

	move_and_slide(velocity)





