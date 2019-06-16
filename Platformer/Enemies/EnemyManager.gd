extends Node


func hack():
	for x in get_children():
		x.call("hack")
func disable_hack():
	for x in get_children():
		x.call("disable_hack")