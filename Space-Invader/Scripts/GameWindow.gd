extends Node2D

onready var enemy = preload("res://Scenes/Enemy.tscn")
onready var missile = preload("res://Scenes/Missile.tscn");
onready var health_img = preload("res://Scenes/Health.tscn");
onready var gunner = preload("res://Scenes/Gunner.tscn")

var total_health = PlayerData.get_health();
var instance;

signal game_over;

var game_status = true;
var enemy_count = 0;

func _ready() -> void:
	$"bg_music".play();
	add_gunner();
	add_enemy();
	add_health();
	enemy_count = get_tree().get_nodes_in_group("Enemy").size();
	_on_EnemyTimer_timeout();
	#PlayerData.connect("health_updated",self,"add_health")
func _process(delta: float) -> void:
	enemy_count = get_tree().get_nodes_in_group("Enemy").size();
	if(enemy_count == 1):
		game_over();
		for nodes in get_tree().get_nodes_in_group("Enemy"):
			nodes.remove_from_group("Enemy")

func add_gunner():
	var gunner_instance = gunner.instance();
	gunner_instance.position = Vector2(400,320)
	gunner_instance.scale.x = .2;
	gunner_instance.scale.y = .2;
	gunner_instance.add_to_group("Gunner");
	add_child(gunner_instance);
	
func add_enemy():
	for i in range(7):
		var Blue = enemy.instance();
		var Red = enemy.instance();
		var Green = enemy.instance();
		var Yellow = enemy.instance();
		
		enemy_properties(Blue, i, 40, "Blue");
		enemy_properties(Red, i, 80, "Red");
		enemy_properties(Green, i, 120, "Green");
		enemy_properties(Yellow, i, 160, "Yellow");
		
func enemy_properties(var prop, var x, var y, var var_name):
	y -= 30;
	prop.scale.x = .15;
	prop.scale.y = .15;
	prop.position = Vector2(210+(60*x) , y)
	prop.get_node(var_name).visible = true;
	prop.add_to_group("Enemy");
	add_child(prop);

func missile_launcher(status):
	if(status == true):
		var missile_instance = missile.instance();
		missile_instance.scale.x = .4;
		missile_instance.scale.y = .3;
		var rnd = rand_range(0,8)
		missile_instance.position = Vector2(210+(60*int(rnd)),60)
		add_child(missile_instance);

func _on_MissileTimer_timeout() -> void:
	missile_launcher(game_status);

func add_health():
	for i in total_health:
		instance = health_img.instance();
		instance.scale.x = .15;
		instance.scale.y = .15;
		instance.name = "health" + str(i);
		instance.position = Vector2(660+(i*40),10)
		add_child(instance);
		instance.add_to_group("Health")

func remove_health(number):
	if(PlayerData.health != 0):
		health_bar_remove(number)
		add_gunner();
	else:
		health_bar_remove(number)
		game_over();

func health_bar_remove(number):
	var instance_name;
	var health_in_group = get_tree().get_nodes_in_group("Health");
	for i in health_in_group:
			instance_name = i.name.substr(0,6) + str(number);
			if(i.name == instance_name):
				i.queue_free()

func game_over():
	emit_signal("game_over");
	$EndAnimation.play("end_scene");
	game_status =  false;
	missile_launcher(game_status)
	$EnemyTimer.stop();
	for nodes in get_tree().get_nodes_in_group("Gunner"):
		if(nodes.name != "GameWindow"):
			nodes.queue_free();

func _on_EnemyTimer_timeout() -> void:
	var group_ele = get_tree().get_nodes_in_group("Enemy");
	for node in group_ele:
		if(node.name != "GameWindow"):
			node.position.y += 30;
