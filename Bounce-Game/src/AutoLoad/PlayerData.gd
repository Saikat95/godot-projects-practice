extends Node2D

signal score_updated;
signal death_updated;

var score: = 0 setget set_score;
var death: = 0 setget set_death;

func set_score(value:int) -> void:
	score = value;
	emit_signal("score_updated");

func set_death(value:int) -> void:
	death = value;
	emit_signal("death_updated");
