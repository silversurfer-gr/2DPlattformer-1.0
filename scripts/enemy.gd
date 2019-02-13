# enemy.gd
extends KinematicBody2D

# unsere Konstanten
const SPEED = 60
const GRAVITY = 10
const FLOOR = Vector2(0, -1)

# unsere Variablen - Variablen werden gewöhnlich klein geschrieben
var velocity = Vector2() # velocity heißt Geschwindigkeit
var direction = 1 #facing right

# unsere erste Funktion
func _physics_process(delta):
	velocity.x = SPEED * direction
	
	if direction == 1:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
		
	$AnimatedSprite.play("walk")

	# Gravitation
	velocity.y += GRAVITY

	velocity = move_and_slide(velocity, FLOOR)
	
	
	if is_on_wall():
		direction *= -1
		$RayCast2D.position.x *= -1
		
	if $RayCast2D.is_colliding() == false:
		direction *= -1
		$RayCast2D.position.x *= -1
	





