extends Node2D

func _on_Restart_pressed() -> void:
	get_tree().change_scene("res://Scenes/Main.tscn");
	PlayerData.score = 0;
	PlayerData.health = 3;


func _on_GameWindow_game_over() -> void:
	$TextureRect/Score.text = "SCORE: " + str(PlayerData.score);
	$TextureRect/Health.text = "health: " + str(PlayerData.health);
