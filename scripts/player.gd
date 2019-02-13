# player.gd
extends KinematicBody2D

# unsere Konstanten
const SPEED = 60
const GRAVITY = 10
const JUMP_POWER = -250
const FLOOR = Vector2(0, -1)

# unsere Variablen - Variablen werden gewöhnlich klein geschrieben
var velocity = Vector2() # velocity heißt Geschwindigkeit
var on_ground = false

# unsere erste Funktion
func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true
	else:
		velocity.x = 0
		$AnimatedSprite.play("idle")
		
	#jump
	if Input.is_action_pressed("ui_up"):
		#erst mal rauslassen, douplejump!
		if on_ground == true:             
			velocity.y = JUMP_POWER
			on_ground = false

	# Gravitation
	velocity.y += GRAVITY
	
	#erst mal rauslassen, douplejump!
	if is_on_floor():
		on_ground = true
	else:
		on_ground = false
		if velocity.y < 0:
			$AnimatedSprite.play("fly")
		else:
			$AnimatedSprite.play("idle")

	velocity = move_and_slide(velocity, FLOOR)





