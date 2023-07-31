extends Node2D

func _ready() -> void:
	$bg_music.play();
	pass

func _on_TextureButton_pressed() -> void:
	get_tree().change_scene("res://Scenes/GameWindow.tscn");
	#Music.bg_music()
