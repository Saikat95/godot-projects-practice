extends Node

export (PackedScene) var mob_scene
var score

func _ready():
	randomize();



func game_over():
	get_node("ScoreTimer").stop();
	get_node("MobTimer").stop();
	get_node("HUD").show_game_over();
	get_tree().call_group("Mobs","queue_free");
	get_node("BackgroundMusic").stop();
	get_node("DeathMusic").play();
	

func new_game():
	score = 0;
	get_node("Player").start(get_node("StartPosition").position);
	get_node("StartTimer").start();
	get_node("HUD").update_score(score);
	get_node("HUD").show_message("GET READY");
	get_node("BackgroundMusic").play();



func _on_StartTimer_timeout():
	get_node("ScoreTimer").start();
	get_node("MobTimer").start();


func _on_ScoreTimer_timeout():
	score += 1;
	get_node("HUD").update_score(score);


func _on_MobTimer_timeout():
	get_node("MobPath/MobSpawnLocation").offset = randi();
	var mob = mob_scene.instance();
	add_child(mob);
	var direction = get_node("MobPath/MobSpawnLocation").rotation + PI/2;
	mob.position = get_node("MobPath/MobSpawnLocation").position;
	direction += rand_range(-PI/4,PI/4);
	mob.rotation = direction;
	mob.linear_velocity = Vector2(rand_range(mob.min_speed,mob.max_speed),0);
	mob.linear_velocity = mob.linear_velocity.rotated(direction);
