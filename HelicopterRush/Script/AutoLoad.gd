extends Node

var life = 3 setget lifeSet;
var time = 60;

var heli = preload("res://Characters/Heli.tscn");

var UI = load("res://Scene/UI.tscn");

func _ready() -> void:
	#var si = UI.instance();
	#add_child(si);
	#get_window().add_child.call_deferred(si)
	pass

func hit():
	life -= 1;
	
func lifeSet(value):
	life = value;
	
func heli_instance():
	var heli_instance = heli.instance();
	heli_instance.scale.x = .7;
	heli_instance.scale.y = .7;
	heli_instance.position.x = 800;
	heli_instance.position.y = 350;
	add_child(heli_instance);
	add_to_group("HeliGroup");
	#print("Heli:",get_tree().get_nodes_in_group("HeliGroup"));
	#print("Enemy: ",get_tree().get_nodes_in_group("EnemyGroup"));

func heli_destroyed():
	var heli_instance = heli.instance();
	heli_instance.queue_free();
