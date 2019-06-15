extends KinematicBody2D

var move = 0
export var speed = 300
var gravity = 9.81
export var jump_force = -400
var velocity = Vector2(0, 0)
var prev_grounded = false
var grounded = false
var attack_done = true


func jump():
	velocity.y = jump_force

func attack():
	$Visual.animation = "Attack"
	attack_done = false
	
func _physics_process(delta):
	move_and_slide(velocity)
	grounded = is_on_wall()
	if velocity.y > 0:
		gravity = 9.81 * 2.25
	else:
		gravity = 9.81

func _process(delta):
		
	if grounded != true:
		$Visual.animation = "InAir"
	else:
		if attack_done:
			if move != 0:
				$Visual.animation = "Run"
			else:
				$Visual.animation = "Idle"
		else:
			if $Visual.frame == 2:
				attack_done = true
	if Input.is_key_pressed(KEY_A):
		move = -1
		$Visual.flip_h = true
		
	
	elif Input.is_key_pressed(KEY_D):
		move = 1
		$Visual.flip_h = false
	else:
		move = 0
		
	if Input.is_key_pressed(KEY_SPACE):
		if grounded:
			jump()
	
	if Input.is_key_pressed(KEY_W):
		if grounded == true:
			attack()
	
	if grounded and !prev_grounded:
		$Visual.animation = "Land"
	velocity.x = move * speed
	
	velocity.y += gravity
	
	prev_grounded = grounded
	