extends Node2D

func bg_music():
	$bg_music.play();
	
func click_sound():
	$click_sound.play();

func blast_sound():
	$blast_sound.play();
	
func stop_music():
	$bg_music.stop();
