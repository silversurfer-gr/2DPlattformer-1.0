# player.gd
extends KinematicBody2D

# unsere Konstanten
const SPEED = 60
const GRAVITY = 10
const JUMP_POWER = -250
const FLOOR = Vector2(0, -1)
const FIREBALL = preload("res://scenes/fireball.tscn") 

# unsere Variablen - Variablen werden gewöhnlich klein geschrieben
var velocity = Vector2() # velocity heißt Geschwindigkeit
var on_ground = false
var is_attacking = false

# unsere erste Funktion
func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		if is_attacking == false:
			velocity.x = SPEED
			$AnimatedSprite.play("walk")
			$AnimatedSprite.flip_h = false
			if sign($Position2D.position.x) == -1:
				$Position2D.position *= -1
	elif Input.is_action_pressed("ui_left"):
		if is_attacking == false:
			velocity.x = -SPEED
			$AnimatedSprite.play("walk")
			$AnimatedSprite.flip_h = true
			if sign($Position2D.position.x) == 1:
				$Position2D.position *= -1
	else:
		velocity.x = 0
		if is_attacking == false:
			$AnimatedSprite.play("idle")
		
	#jump
	if Input.is_action_pressed("ui_up"):
		if is_attacking == false:
			#erst mal rauslassen, douplejump!
			if on_ground == true:             
				velocity.y = JUMP_POWER
				on_ground = false

	#attack 
	if Input.is_action_just_pressed("ui_accept") && is_attacking == false:
		is_attacking = true
		$AnimatedSprite.play("attack")
		var fireball = FIREBALL.instance()
		if sign($Position2D.position.x) == 1:
			fireball.set_fireball_direction(1)
		else:
			fireball.set_fireball_direction(-1)
		get_parent().add_child(fireball)
		fireball.position = $Position2D.global_position
		

	# Gravitation
	velocity.y += GRAVITY
	
	#erst mal rauslassen, douplejump!
	if is_on_floor():
		on_ground = true
	else:
		if is_attacking == false:
			on_ground = false
			if velocity.y < 0:
				$AnimatedSprite.play("fly")
			else:
				$AnimatedSprite.play("idle")

	velocity = move_and_slide(velocity, FLOOR)


func _on_AnimatedSprite_animation_finished():
	is_attacking = false
