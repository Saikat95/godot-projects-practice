extends Node2D

var GameScreen = load("res://Scene/GameWindow.tscn");

func _on_settingButton_pressed() -> void:
	$AnimationPlayer.slide_in();
	Music.click_sound();


func _on_backButton_pressed() -> void:
	$AnimationPlayer.slide_out();
	Music.click_sound();


func _on_playButton_pressed() -> void:
	Music.click_sound();
	get_tree().change_scene("res://Scene/GameWindow.tscn");
