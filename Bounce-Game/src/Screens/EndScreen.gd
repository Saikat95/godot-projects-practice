extends Control

onready var score: Label = get_node("Label");

func _ready():
	score.text = score.text % [PlayerData.score,PlayerData.death];

func _on_PlayButton_pressed() -> void:
	get_tree().change_scene("res://src/Scene/level01.tscn");

func _on_QuitButton_pressed() -> void:
	get_tree().quit();
