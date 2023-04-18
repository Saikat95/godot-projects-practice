extends Node2D

export var next_scene:PackedScene;

func _ready() -> void:
	Music.play_music();

func _on_Button_pressed() -> void:
	get_tree().change_scene_to(next_scene);
