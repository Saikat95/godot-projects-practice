extends Node

func _bg_music():
	$BG.play()

func _apple_bite():
	$Crunch.play()
	
func _wall_hit():
	$Wall_hit.play()
