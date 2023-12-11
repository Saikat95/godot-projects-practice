extends KinematicBody2D

var time: = 0.0;
var speed: = 2.0;
var radius: = 100.0;
var ran_pos_x;
var ran_pos_y;

func _ready() -> void:
	randomize()
	ran_pos_x = coordinateX();
	ran_pos_y = coordinateY();

func _process(delta: float) -> void:
	time += delta;
	#position = Vector2(sin(time * speed) * radius , cos(time * speed) * radius) + Vector2(250,250);
	var angle = speed * time;
	var rotation = Vector2(cos(angle),sin(angle));
	position = (rotation * radius) + Vector2(ran_pos_x,ran_pos_y);

func coordinateX():
	var finalX;
	finalX = round(-100 + randi() % 250);
	if(finalX > 450 && finalX <950):
		coordinateX();
	return finalX;

func coordinateY():
	var finalY;
	finalY = round(900 + randi() % 300);
	if(finalY > 350 && finalY < 620):
		coordinateY();
	return finalY;
	

func _on_Area2D_body_entered(body: Node) -> void:
	if(body.name.validate_node_name().begins_with("Bullet")):
		enemy_death(body);
	
func enemy_death(body):
	queue_free()
	Music.enemy_die.play();
	Ui_Script.enemy_count()
	body.queue_free();
  
func _on_HeliDetect_body_entered(body: Node) -> void:
	if(body.name.validate_node_name().begins_with("Heli")):
		heli_destroyed(body);

func heli_destroyed(body):
	Music.blast.play();
	body.queue_free();
	Ui_Script.heart_drop();
	if(Global.life > 1):
		Global.heli_instance();
	if(Global.life > 0):
		Global.hit()
