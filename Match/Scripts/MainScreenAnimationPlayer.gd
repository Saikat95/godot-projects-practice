extends AnimationPlayer

func slide_in():
	$".".play("mainScreen_ani");

func slide_out():
	$".".play_backwards("mainScreen_ani");
