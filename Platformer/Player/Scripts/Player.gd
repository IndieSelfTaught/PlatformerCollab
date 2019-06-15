extends KinematicBody2D

var move = 0
export var speed = 200
var gravity = 9.81
export var jump_force = -250
var velocity = Vector2(0, 0)

func move():
	move_and_slide(velocity)

func jump():
	velocity.y = jump_force

func enter():
	pass

func down():
	pass

func _process(delta):
	if Input.is_key_pressed(KEY_A):
		move = -1
		$Visual.flip_h = true
	
	elif Input.is_key_pressed(KEY_D):
		move = 1
		$Visual.flip_h = false
	else:
		move = 0
		
	if Input.is_key_pressed(KEY_SPACE):
		jump()
	
	if Input.is_key_pressed(KEY_W):
		enter()
	
	if Input.is_key_pressed(KEY_S):
		down()
	
	velocity.x = move * speed
	
	velocity.y += gravity
	
	move()