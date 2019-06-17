extends KinematicBody2D

var hacked = false

func hack():
	hacked = true
	if name == "LaserMid":
		$Visual.animation = "Hacked Mid"
	else:
		$Visual.animation = "Hacked Base"
func disable_hack():
	hacked = false
	if name == "LaserMid":
		$Visual.animation = "Normal Mid"
	else:
		$Visual.animation = "Normal Base"
func kill():
	$Collider.disabled = true