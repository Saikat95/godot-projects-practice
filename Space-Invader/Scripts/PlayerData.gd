extends Node2D

signal score_updated;
signal health_updated(health);
var score: = 0 setget score_updated;
var health: = 3 setget health_updated, get_health;

func score_updated(value):
	score = value;

func health_updated(value):
	health = value;

func get_health():
	return health;
