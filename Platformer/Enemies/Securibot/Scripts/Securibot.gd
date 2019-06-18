extends KinematicBody2D


var wall = false

var normal_velocity = Vector2(60, 0)
var velocity = Vector2(normal_velocity.x, 0)
var hacked_velocity = Vector2(30, 0)
var died = false

var hacked = false

func hack():
	hacked = true
	$Visual.animation = "RunHacked"
	$Visual.speed_scale = .25
	velocity.x = hacked_velocity.x
func disable_hack():
	hacked = false
	if died != true:
		$Visual.animation = "Run"
		$Visual.speed_scale = 1
		velocity.x = normal_velocity.x

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

func OnDeath():
	queue_free()


func OnBodyEnter(body):
	if "Player" in body.name or "One Way" in body.get_parent().name:
		pass
	else:
		wall = true


func OnBodyExit(body):
	wall = true
	get_node("LedgeCheck0/Collider").disabled = true
	get_node("LedgeCheck1/Collider").disabled = true
	$LedgeCheckCooldown.start()


func OnLedgeCheckReady():
	get_node("LedgeCheck0/Collider").disabled = false
	get_node("LedgeCheck1/Collider").disabled = false
