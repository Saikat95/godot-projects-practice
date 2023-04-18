extends Node2D

func play_music():
	$BGMusic.play();

func play_pop_music():
	$BrickPop.play();

func play_paddle_music():
	$PaddleHit.play();

func play_death_music():
	$Death.play();
