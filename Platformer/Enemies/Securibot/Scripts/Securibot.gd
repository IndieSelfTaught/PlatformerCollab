extends KinematicBody2D


var wall = false

var normal_velocity = Vector2(-60, 0)
var velocity = normal_velocity
var hacked_velocity = Vector2(-30, 0)
var died = false

var hacked = false

func hack():
	hacked = true
	$Visual.animation = "RunHacked"
	$Visual.speed_scale = .5
	velocity = hacked_velocity
func disable_hack():
	hacked = false
	if died != true:
		$Visual.animation = "Run"
		$Visual.speed_scale = 1
		velocity = normal_velocity

func kill():
	$Collider.disabled = true
	died = true
	$DeathTimer.start()

func _process(delta):
	if died != true:
		move_and_slide(velocity)
		if wall == true:
			velocity.x = -velocity.x
			$Visual.flip_h = !$Visual.flip_h
			wall = false
	if $GroundCheck0.is_colliding() == false or $GroundCheck1.is_colliding() == false:
		wall = true
		$GroundCheck0.enabled = false
		$GroundCheck1.enabled = false
		$GroundCheckTimeout.start()

func OnDeath():
	queue_free()


func OnBodyEnter(body):
	if "Player" in body.name or "One Way" in body.get_parent().name:
		pass
	else:
		wall = true

func OnGroundCheckReady():
	$GroundCheck0.enabled = true
	$GroundCheck1.enabled = true
