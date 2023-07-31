extends Node2D

func bg_music():
	get_node("bg_music").play();

func fire_sound():
	$fire.play();

func destroy_bg():
	$destroy.play();
