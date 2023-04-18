extends Node2D

signal health_updated(new_health);
signal no_health;
signal score_changed(new_score);

export var health: = 5 setget health_changed;
var score: = 0 setget score_updated;
var paddleFrame = 0;
var music = load("res://Assets/House In a Forest Loop.ogg");

func health_changed(value):
	health = value;
	emit_signal("health_updated",health);
	if(health <= 0):
		emit_signal('no_health');

func score_updated(value):
	score = value;
	emit_signal("score_changed",value);
	
func play_music():
	$Music.play();
