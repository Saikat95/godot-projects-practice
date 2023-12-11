extends TextureButton

func _on_Button_pressed() -> void:
	get_node("/root/StartMenu/StartScene").layer = -1;
	get_tree().change_scene("res://Scene/PlayWindow.tscn");
	Music.heli.play();
