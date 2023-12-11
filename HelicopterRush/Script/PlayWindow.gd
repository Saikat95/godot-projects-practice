extends Node2D

var EnemyPos1 = preload("res://Characters/Enemy1.tscn");
var EnemyPos2 = preload("res://Characters/Enemy2.tscn");
var EnemyPos3 = preload("res://Characters/Enemy3.tscn");
var EnemyPos4 = preload("res://Characters/Enemy4.tscn");
var EnemyPos5 = preload("res://Characters/Enemy5.tscn");
var EnemyPos6 = preload("res://Characters/Enemy6.tscn");

onready var ani = $AnimationPlayer;

var totalLife = Global.life;

var enemy1Diff = 0 setget enemy1Diffset;

var time = Global.time;
onready var timer = get_node("/root/Ui/TimerContainer/Timer")

func _ready() -> void:
	enemy_instance()
	Global.heli_instance();

func enemy1Diffset(value):
	enemy1Diff = value;

func enemy_instance():
	enemy1Diff = 10;
	
	for i in 3:
		var enemy_instance = EnemyPos1.instance();
		enemy_instance.scale.x = .2;
		enemy_instance.scale.y = .2;
		enemy1Diff = enemy1Diff + 20;
		enemy_instance.position.x = enemy1Diff;
		enemy_instance.position.y = enemy1Diff;
		if((enemy_instance.position.x < 450 || enemy_instance.position.x > 950) && (enemy_instance.position.y < 250 || enemy_instance.position.y > 620)):
			add_child(enemy_instance);
			enemy_instance.add_to_group("EnemyGroup");
	
	enemy1Diff = 10;
	
	for i in 3:
		var enemy_instance = EnemyPos2.instance();
		enemy_instance.scale.x = .2;
		enemy_instance.scale.y = .2;
		enemy1Diff = enemy1Diff + 20;
		enemy_instance.position.x = enemy1Diff;
		enemy_instance.position.y = enemy1Diff;
		if((enemy_instance.position.x < 450 || enemy_instance.position.x > 950) && (enemy_instance.position.y < 250 || enemy_instance.position.y > 620)):
			add_child(enemy_instance);
	
	enemy1Diff = 10;
	
	for i in 3:
		var enemy_instance = EnemyPos3.instance();
		enemy_instance.scale.x = .2;
		enemy_instance.scale.y = .2;
		enemy1Diff = enemy1Diff + 20;
		enemy_instance.position.x = enemy1Diff;
		enemy_instance.position.y = enemy1Diff;
		if((enemy_instance.position.x < 450 || enemy_instance.position.x > 950) && (enemy_instance.position.y < 250 || enemy_instance.position.y > 620)):
			add_child(enemy_instance);
	
	enemy1Diff = 10;
	
	for i in 3:
		var enemy_instance = EnemyPos4.instance();
		enemy_instance.scale.x = .2;
		enemy_instance.scale.y = .2;
		enemy1Diff = enemy1Diff + 20;
		enemy_instance.position.x = enemy1Diff;
		enemy_instance.position.y = enemy1Diff;
		if((enemy_instance.position.x < 450 || enemy_instance.position.x > 950) && (enemy_instance.position.y < 250 || enemy_instance.position.y > 620)):
			add_child(enemy_instance);
	
	enemy1Diff = 10;
	
	for i in 3:
		var enemy_instance = EnemyPos5.instance();
		enemy_instance.scale.x = .2;
		enemy_instance.scale.y = .2;
		enemy1Diff = enemy1Diff + 20;
		enemy_instance.position.x = enemy1Diff;
		enemy_instance.position.y = enemy1Diff;
		if((enemy_instance.position.x < 450 || enemy_instance.position.x > 950) && (enemy_instance.position.y < 250 || enemy_instance.position.y > 620)):
			add_child(enemy_instance);
			
	enemy1Diff = 10;
	
	for i in 3:
		var enemy_instance = EnemyPos6.instance();
		enemy_instance.scale.x = .2;
		enemy_instance.scale.y = .2;
		enemy1Diff = enemy1Diff + 20;
		enemy_instance.position.x = enemy1Diff;
		enemy_instance.position.y = enemy1Diff;
		if((enemy_instance.position.x < 450 || enemy_instance.position.x > 950) && (enemy_instance.position.y < 250 || enemy_instance.position.y > 620)):
			add_child(enemy_instance);

func _on_Timer_timeout() -> void:
	if(Ui_Script.enemy_no == 0):
		win();
	if(time == 0 || Global.life == 0):
		destroy();
	if(time != 0):
		time -= 1;
		timer.text = str(time);

func destroy():
	Music.heli.stop();
	var heliGroup = get_tree().get_nodes_in_group("Heli_Group");
	$LooseScene.layer = 1;
	$Timer.stop();
	for heli_in in heliGroup:
		heli_in.queue_free();

func win():
	Music.heli.stop();
	var heliGroup = get_tree().get_nodes_in_group("Heli_Group");
	$WinScene.layer = 1;
	$Timer.stop();
	for heli_in in heliGroup:
		heli_in.queue_free();
	
