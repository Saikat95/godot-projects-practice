extends KinematicBody2D

var speed = 800.0;
var velocity = Vector2(0,0);
signal bullet_fired_signal
onready var bullet = load("res://Scenes/Bullet.tscn")

func _physics_process(delta: float) -> void:
	gunner();
	if(Input.is_action_just_pressed("ui_accept")):
		$fire.play();
		emit_signal("bullet_fired_signal",add_bullet());
	
func get_gunner_direction():
	return (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"));

func gunner():
	var direction = get_gunner_direction();
	velocity.x = direction * speed;
	velocity.y = 0.0;
	velocity = move_and_slide(velocity);

func add_bullet():
	var instance = bullet.instance();
	instance.scale.x = .2;
	instance.scale.y = .2
	add_child(instance);

func _on_Area2D_area_entered(area: Area2D) -> void:
	if(area in get_tree().get_nodes_in_group("Enemy")):
		queue_free();
		PlayerData.health = 0;
		get_parent().remove_health(PlayerData.health);
		get_parent().game_over();
