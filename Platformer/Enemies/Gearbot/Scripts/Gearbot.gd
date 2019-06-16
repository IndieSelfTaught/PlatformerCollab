extends KinematicBody2D

var died = false

var hacked = false


var normal_speed = 30
var speed = normal_speed
var hacked_speed = 15
var direction = Vector2(0, 1)

func kill():
	$Collider.disabled = true
	died = true
	$DeathTimer.start()
func hack():
	hacked = true
	$Visual.animation = "RotateHacked"
	speed = hacked_speed
func disable_hack():
	hacked = false
	$Visual.animation = "Rotate"
	speed = normal_speed
	
func _process(delta):
	if died != true:
		move_and_slide(direction * speed)
		$Visual.playing = true
	else:
		$Visual.playing = false
	if $Right.is_colliding() and $Bottom.is_colliding():
		if direction.x != 0:
			direction = Vector2(0, -1)
		else:
			direction = Vector2(1, 0)
	elif $Right.is_colliding() and $Top.is_colliding():
		if direction.x != 0:
			direction = Vector2(0, 1)
		else:
			direction = Vector2(1, 0)
	elif $Left.is_colliding() and $Top.is_colliding():
		if direction.x != 0:
			direction = Vector2(0, 1)
		else:
			direction = Vector2(-1, 0)
	elif $Left.is_colliding() and $Bottom.is_colliding():
		if direction.x != 0:
			direction = Vector2(0, -1)
		else:
			direction = Vector2(-1, 0)
			

func OnDeath():
	self.queue_free()
