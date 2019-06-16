extends KinematicBody2D

export var boundaries = 80
export var speed = 60
export var speed_while_sprinting = 80
var player_existant = true

onready var player = get_parent().get_node("Player")

func _process(delta):
	if player_existant:
		if player.transform.origin.x > transform.origin.x + boundaries:
			if player.get("sprinting"):
				move_and_slide(Vector2(speed_while_sprinting, 0))
			else:
				move_and_slide(Vector2(speed, 0))

		elif player.transform.origin.x < transform.origin.x - boundaries:
			if player.get("sprinting"):
				move_and_slide(Vector2(-speed_while_sprinting, 0))
			else:
				move_and_slide(Vector2(-speed, 0))