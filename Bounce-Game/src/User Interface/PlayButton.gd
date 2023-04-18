extends Button

func _on_PlayButton_pressed() -> void:
	PlayerData.score = 0;
	get_tree().paused = false;
	get_tree().change_scene("res://src/Scene/level01.tscn");
