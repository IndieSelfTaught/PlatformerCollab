extends KinematicBody2D

var move = 0
export var speed = 60
var gravity = 1.962
export var jump_force = -130
var velocity = Vector2(0, 0)
var prev_grounded = false
var grounded = false
var attack_done = true
var sprinting = false
var sprint_speed = 80
var died = false


func jump():
	velocity.y = jump_force

func attack():
	$Visual.animation = "Attack"
	attack_done = false
	$AttackTimer.start()
	
func _physics_process(delta):
	if died != true:
		move_and_slide(velocity)
	grounded = is_on_wall()
	if velocity.y > 0:
		gravity = 1.962 * 2.50
	else:
		gravity = 1.962

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
		if died != true:
			$Visual.flip_h = true
		
	
	elif Input.is_key_pressed(KEY_D):
		move = 1
		if died != true:
			$Visual.flip_h = false
	else:
		move = 0
		
	if Input.is_key_pressed(KEY_SPACE):
		if grounded:
			jump()
	
	if Input.is_key_pressed(KEY_W):
		attack()
	sprinting = Input.is_key_pressed(KEY_SHIFT)
	if grounded and !prev_grounded:
		$Visual.animation = "Land"
	
	if sprinting:
		velocity.x = move * sprint_speed
		$Visual.speed_scale = 1.25
	else:
		velocity.x = move * speed
		$Visual.speed_scale = 1
	
	velocity.y += gravity
	
	prev_grounded = grounded
	
func die():
	died = true
	$DeathTimer.start()

func OnDeath():
	get_parent().get_node("CameraRoot").set("player_existant", false)
	queue_free()


func OnAreaEnter(area):
		if area.get_parent().name == "Securibot" or area.get_parent().name == "Gearbot":
			if area.get_parent().hacked != true:
				if attack_done:
					die()
				else:
					area.get_parent().call("kill")
			else:
				area.get_parent().call("kill")


func OnAttackDone():
	attack_done = true
