#fireball.gd
extends Area2D

const SPEED = 100

var velovity = Vector2()
var direction = 1 #facing right

func _ready():
	pass
	
func set_fireball_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true

func _physics_process(delta):
	velovity.x = SPEED * delta * direction
	
	translate(velovity)
	$AnimatedSprite.play("shoot")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_fireball_body_entered(body):
	queue_free()
