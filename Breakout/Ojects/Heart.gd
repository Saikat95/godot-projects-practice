extends Node2D

var hearts = 0;

onready var heart_pic = preload("res://Ojects/HeartStatus.tscn");

func set_hearts(value):
	hearts = value;
	if(hearts > -1):
		if($heart.rect_size.x > 480):
			$heart.rect_size.x = $heart.rect_size.x - 410;
		else:
			$heart.queue_free();

func _ready():
	self.hearts = PlayerData.health;
	PlayerData.connect("health_updated",self,"set_hearts");
