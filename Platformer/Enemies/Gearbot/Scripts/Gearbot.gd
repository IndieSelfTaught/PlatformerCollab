extends KinematicBody2D

var died = false

var hacked = false


var normal_speed = 30
var speed = normal_speed
var hacked_speed = 15
var move = 1

export var vertical = false

func kill():
	$Collider.disabled = true
	died = true
	$DeathTimer.start()
func hack():
	hacked = true
	if vertical:
		$Visual.animation = "V Hacked"
	else:
		$Visual.animation = "H Hacked"
	speed = hacked_speed
func disable_hack():
	hacked = false
	if vertical:
		$Visual.animation = "V"
	else:
		$Visual.animation = "H"
	speed = normal_speed
	
func _ready():
	if vertical:
		$Visual.animation = "V"
	else:
		$Visual.animation = "H"
func _process(delta):
	if died != true:
		if vertical:
			move_and_slide(Vector2(0, speed * move))
		else:
			move_and_slide(Vector2(-speed * move, 0))
		if is_on_wall():
			move = -move
		$Visual.playing = true
			

func OnDeath():
	self.queue_free()
