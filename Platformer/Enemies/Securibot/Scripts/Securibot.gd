extends KinematicBody2D

export var walk_distance = 180

var velocity = Vector2(-60, 0)

var current = 0

func _process(delta):
	move_and_slide(velocity)
	
	if current >= walk_distance:
		current = 0
		velocity.x = -velocity.x
		$Visual.flip_h = !$Visual.flip_h
	else:
		current += 1